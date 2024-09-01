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



  recuperar(int idAlbum) async {
    db = await Banco.instancia.database;

    _stickers.clear();
    stickersInterface.clear();

    

    final List<Map<String, dynamic>> stickersMap = await db.query(
        kTableNameSticker,
        where: "$kTableStickerColumnIdAlbum = ?",
        whereArgs: [idAlbum]);

    for (int i = 0; i < stickersMap.length; i++) {
      _stickers.add(StickerModel.fromMap(stickersMap[i]));
    }
    stickersInterface.addAll(_stickers);
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
        stickersInterface.clear();
        stickersInterface.addAll(_stickers);
        break;
      }
    }

    debugPrint("🏦🃏RPS atualizar() id: ${sticker.id}");
    debugPrint("🏦🃏RPS atualizar() id: ${sticker.toMap()}");

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
    //notifyListeners();

    switch (filtro) {
      case 'Repetidas':
        debugPrint("🏦🃏RPS filtrar() filtro: entrou $filtro");
        for (var element in _stickers) {
          if (element.quantidade > 1) {
            stickersInterface.add(element);
          }
        }
        break;
      case 'Faltantes':
        for (var element in _stickers) {
          if (element.quantidade == 0) {
            debugPrint("🏦🃏RPS filtrar() filtro: entrou $filtro if");
            stickersInterface.add(element);
          }
        }
        break;
      default:
        debugPrint("🏦🃏RPS filtrar() filtro: entrou $filtro");
        stickersInterface.addAll(_stickers);
        break;
    }

    notifyListeners();
    debugPrint("🏦🃏RPS filtrar() filtro: $filtro");
    debugPrint(
        "🏦🃏RPS filtrar() filtro: ${stickersInterface.length} elementos");
  }
}
