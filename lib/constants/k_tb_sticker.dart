import 'k_tb_album.dart';

const String kNameTableSticker = "tb_stickers";

const String kTableStickerColumnId = "id";
const String kTableStickerColumnIdAlbum = "id_album";
const String kTableStickerColumnUrl = "url";
const String kTableStickerColumnQuantidade = "quantidade";
const String kTableStickerColumnPosicao = "posicao";

const String kCreateTableSticker = """
CREATE TABLE $kNameTableSticker (
  $kTableStickerColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $kTableStickerColumnIdAlbum INTEGER NOT NULL,
  $kTableStickerColumnUrl TEXT NOT NULL,
  $kTableStickerColumnQuantidade INTEGER NOT NULL,
  $kTableStickerColumnPosicao INTEGER NOT NULL,
  FOREIGN KEY ($kTableStickerColumnIdAlbum) REFERENCES $kTableNameAlbum ($kTableAlbumColumnId)
);
""";
