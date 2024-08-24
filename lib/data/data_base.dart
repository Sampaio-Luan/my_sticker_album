import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/k_tb_album.dart';
import '../constants/k_tb_sticker.dart';

class Banco {
  Banco._();

  static final Banco instancia = Banco._();

  static Database? _database;

  Future<Database> get database async {
// await deleteDatabase(
    //   join(await getDatabasesPath(), 'banco.db'),
    // );
    // debugPrint('Banco deletado !!!');

    if (_database != null) {
      return _database!;
    }
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'banco.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(kCreateTableAlbum);
    await db.execute(kCreateTableSticker);

    debugPrint('Banco criado com sucesso !!!');
  }
}
