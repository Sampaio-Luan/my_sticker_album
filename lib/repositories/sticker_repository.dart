import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../constants/k_tb_sticker.dart';
import '../data/data_base.dart';
import '../models/sticker.module.dart';

class AlbumRepository extends ChangeNotifier {
  final List<StickerModel> _stickers = [];
  get stickers => _stickers;

  late Database db;

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
}
