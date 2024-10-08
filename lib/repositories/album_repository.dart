import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:my_sticker_album/constants/k_tb_sticker.dart';

import '../constants/k_tb_album.dart';
import '../data/data_base.dart';
import '../models/album.module.dart';
import '../models/sticker.module.dart';

class AlbumRepository extends ChangeNotifier {
  final List<AlbumModel> _albums = [];
  get getAlbums => _albums;

  bool isForm = false;
  bool isEdit = false;
  AlbumModel? selecionadoAlbumEdit;

  void setForm(
      {required bool form, required bool editar, required AlbumModel? album}) {
    isForm = form;
    isEdit = editar;
    selecionadoAlbumEdit = album;
    notifyListeners();
  }

  late Database db;

  // AlbumModel album1 = AlbumModel(
  //   id: 1,
  //   nome: 'Album 1',
  //   descricao: 'Descrição do album 1',
  //   capa: 'https://nerdtatuado.com.br/wp-content/uploads/2022/05/handler-2.png',
  //   posicoes: 20,
  //   criacao: '2022-01-01',
  //   temaCor: 1,
  //   quantidadeFigurinhas: 10,
  // );

  AlbumRepository() {
    if (_albums.isEmpty) {
      recuperar();
    }
  }

  recuperar() async {
    db = await Banco.instancia.database;

    _albums.clear();

    notifyListeners();

    final List<Map<String, dynamic>> albumsMap = await db.rawQuery(kQueryAlbum);

    for (int i = 0; i < albumsMap.length; i++) {
      _albums.add(AlbumModel.fromMap(albumsMap[i]));
      debugPrint("🥱👽RPA recuperar() album: ${albumsMap[i]}");
    }

    debugPrint("🥱👽RPA recuperar() albums: ${_albums.length}");
    notifyListeners();

    return _albums;
  }

  criar(AlbumModel album) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      kTableNameAlbum,
      album.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    album.id = id;
    _albums.add(album);

    List<StickerModel> stickers = [];

    for (int i = 0; i < album.posicoes; i++) {
      stickers.add(StickerModel(
        id: 0,
        idAlbum: id,
        imagem: '',
        posicao: i + 1,
        quantidade: 0,
        nome: '',
        descricao: '',
      ));
    }
    for (int i = 0; i < album.posicoes; i++) {
      await db.insert(
        kTableNameSticker,
        stickers[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    debugPrint("🥱👽RPA criar() id: $id");

    notifyListeners();
  }

  atualizar(AlbumModel album) async {
    db = await Banco.instancia.database;

    await db.update(
      kTableNameAlbum,
      album.toMap(),
      where: '$kTableAlbumColumnId = ?',
      whereArgs: [album.id],
    );

    for (int i = 0; i < _albums.length; i++) {
      if (_albums[i].id == album.id) {
        _albums[i] = album;
        break;
      }
    }

    debugPrint("🥱👽RPA atualizar() id: ${album.nome}");

    notifyListeners();
  }

  deletar(AlbumModel album) async {
    db = await Banco.instancia.database;

    await db.delete(
      kTableNameAlbum,
      where: '$kTableAlbumColumnId = ?',
      whereArgs: [album.id],
    );

    _albums.removeWhere((element) => element.id == album.id);

    debugPrint("🥱👽RPA excluir() id: ${album.nome}");

    notifyListeners();
  }

  addOrRemoveSticker(AlbumModel album) {
    for (int i = 0; i < _albums.length; i++) {
      if (_albums[i].id == album.id) {
        _albums[i] = album;

        break;
      }
    }
    debugPrint(
        "🥱👽RPA addOrRemoveSticker() qtd: ${album.quantidadeFigurinhas}");

    notifyListeners();
  }

  // mudarTema(int cor) {
  //   album1.temaCor = cor;
  //   notifyListeners();
  // }
}
