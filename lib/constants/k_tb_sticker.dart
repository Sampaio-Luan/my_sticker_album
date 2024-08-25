import 'k_tb_album.dart';

const String kTableNameSticker = "tb_stickers";

const String kTableStickerColumnId = "id";
const String kTableStickerColumnIdAlbum = "id_album";
const String kTableStickerColumnImagem = "imagem";
const String kTableStickerColumnQuantidade = "quantidade";
const String kTableStickerColumnPosicao = "posicao";
const String kTableStickerColumnNome = "nome";
const String kTableStickerColumnDescricao = "descricao";

const String kCreateTableSticker = """
CREATE TABLE $kTableNameSticker (
  $kTableStickerColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $kTableStickerColumnIdAlbum INTEGER NOT NULL,
  $kTableStickerColumnImagem TEXT NOT NULL,
  $kTableStickerColumnPosicao INTEGER NOT NULL,
  $kTableStickerColumnQuantidade INTEGER NOT NULL,
  $kTableAlbumColumnNome TEXT NOT NULL,
  $kTableAlbumColumnDescricao TEXT NOT NULL,
  FOREIGN KEY ($kTableStickerColumnIdAlbum) REFERENCES $kTableNameAlbum ($kTableAlbumColumnId)
);
""";
