import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/k_tb_sticker.dart';
import '../data/data_base.dart';
import '../models/sticker.module.dart';

class StickerRepository extends ChangeNotifier {
  final List<StickerModel> _stickers = [];
  get getStickers => _stickers;
  List<StickerModel> stickersInterface = [];
  late Database db;

  StickerModel sticker = StickerModel(
    id: 1,
    idAlbum: 1,
    imagem:
        'https://s2-g1.glbimg.com/R9MLvKO92PP_78wMTCvDKozTh8A=/0x0:1518x916/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2019/7/L/AhD3O2Rguo4YQNpBTkEQ/grifi.jpg',
    posicao: 3,
    quantidade: 1,
    nome: '',
    descricao: '',
  );

  StickerRepository() {
    //_stickers.add(sticker);

    if (_stickers.isEmpty) {
      prenncher();
      //recuperar(1);
    }
  }

  prenncher() {
    for (int i = 1; i < 20; i++) {
      if (i == 3) {
        _stickers.add(sticker);
      } else {
        _stickers.add(
          StickerModel(
            id: i,
            idAlbum: 1,
            imagem: '',
            posicao: i,
            quantidade: 0,
            nome: '',
            descricao: '',
          ),
        );
      }
    }
    stickersInterface.addAll(_stickers);
  }

  recuperar(int idAlbum) async {
    db = await Banco.instancia.database;

    _stickers.clear();

    notifyListeners();

    final List<Map<String, dynamic>> stickersMap = await db.query(
        kTableNameSticker,
        where: "$kTableStickerColumnIdAlbum = ?",
        whereArgs: [idAlbum]);

    for (int i = 0; i < stickersMap.length; i++) {
      _stickers.add(StickerModel.fromMap(stickersMap[i]));
    }
    stickersInterface = _stickers;
    debugPrint("🏦🃏RPS recuperar() stickers: ${_stickers.length}");

    notifyListeners();

    return _stickers;
  }

  criar(StickerModel sticker) async {
    db = await Banco.instancia.database;

    final id = await db.insert(
      kTableNameSticker,
      sticker.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    sticker.id = id;
    _stickers.add(sticker);

    debugPrint("🏦🃏RPS criar() id: $id");

    notifyListeners();
  }

  atualizar(StickerModel sticker) async {
    db = await Banco.instancia.database;

    await db.update(
      kTableNameSticker,
      sticker.toMap(),
      where: '$kTableStickerColumnId = ?',
      whereArgs: [sticker.id],
    );

    for (int i = 0; i < _stickers.length; i++) {
      if (_stickers[i].id == sticker.id) {
        _stickers[i] = sticker;
        break;
      }
    }

    debugPrint("🏦🃏RPS atualizar() id: ${sticker.nome}");

    notifyListeners();
  }

  deletar(StickerModel sticker) async {
    db = await Banco.instancia.database;

    await db.delete(
      kTableNameSticker,
      where: '$kTableStickerColumnId = ?',
      whereArgs: [sticker.id],
    );

    _stickers.remove(sticker);
    debugPrint("🏦🃏RPS deletar() id: ${sticker.nome}");

    notifyListeners();
  }

  filtrar(String filtro) {
    stickersInterface.clear();
    notifyListeners();

    switch (filtro) {
      case 'Repetidas':
        for (var element in _stickers) {
          if (element.quantidade > 1) {
            stickersInterface.add(element);
          }
        }
        break;
      case 'Faltantes':
        for (var element in _stickers) {
          if (element.quantidade == 0) {
            stickersInterface.add(element);
          }
        }
        break;
      default:
        stickersInterface.addAll(_stickers);
        break;
    }

    notifyListeners();
    debugPrint("🏦🃏RPS filtrar() filtro: ${stickersInterface.length}");
    debugPrint("🏦🃏RPS filtrar() filtro: $filtro");
  }
}
