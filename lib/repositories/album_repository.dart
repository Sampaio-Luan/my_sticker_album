import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/k_tb_album.dart';
import '../data/data_base.dart';
import '../models/album.module.dart';

class AlbumRepository extends ChangeNotifier {
  final List<AlbumModel> _albums = [];
  get getAlbums => _albums;

  bool isForm = false;

  void setForm(bool value) {
    isForm = value;
    notifyListeners();
  }

  late Database db;

  AlbumModel album1 = AlbumModel(
    id: 1,
    nome: 'Album 1',
    descricao: 'Descrição do album 1',
    capa: 'https://nerdtatuado.com.br/wp-content/uploads/2022/05/handler-2.png',
    posicoes: 20,
    criacao: '2022-01-01',
    temaCor: 1,
    quantidadeFigurinhas: 10,
  );

 

  AlbumRepository() {
     _albums.add(album1);
    if (_albums.isEmpty) {
      recuperar();
    }
  }

  recuperar() async {
    db = await Banco.instancia.database;

    _albums.clear();

    notifyListeners();

    final List<Map<String, dynamic>> albumsMap =
        await db.rawQuery(kQueryAlbum);

    for (int i = 0; i < albumsMap.length; i++) {
      _albums.add(AlbumModel.fromMap(albumsMap[i]));
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

  mudarTema(int cor){
    album1.temaCor = cor;
    notifyListeners();
  }
}
