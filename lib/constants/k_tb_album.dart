const String kTableNameAlbum = "tb_albums";

const String kTableAlbumColumnId = "id";
const String kTableAlbumColumnNome = "nome";
const String kTableAlbumColumnDescricao = "descricao";
const String kTableAlbumColumnUrl = "url";
const String kTableAlbumColumnPosicoes = "posicoes";
const String kTableAlbumColumnCriacao = "criacao";


const String kCreateTableAlbum = """
CREATE TABLE $kTableNameAlbum (
  $kTableAlbumColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $kTableAlbumColumnNome TEXT NOT NULL,
  $kTableAlbumColumnDescricao TEXT NOT NULL,
  $kTableAlbumColumnUrl TEXT NOT NULL,
  $kTableAlbumColumnPosicoes INTEGER NOT NULL,
  $kTableAlbumColumnCriacao TEXT NOT NULL
);
""";