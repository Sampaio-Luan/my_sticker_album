import 'package:my_sticker_album/constants/k_tb_sticker.dart';

const String kTableNameAlbum = "tb_albums";

const String kTableAlbumColumnId = "id";
const String kTableAlbumColumnNome = "nome";
const String kTableAlbumColumnDescricao = "descricao";
const String kTableAlbumColumnCapa = "capa";
const String kTableAlbumColumnPosicoes = "posicoes";
const String kTableAlbumColumnCriacao = "criacao";
const String kTableAlbumColumnTemaCor = "tema";

const String kAlbumQuantidadeFigurinhas = "quantidade_figurinhas";

const String kCreateTableAlbum = """
CREATE TABLE $kTableNameAlbum (
  $kTableAlbumColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $kTableAlbumColumnNome TEXT NOT NULL,
  $kTableAlbumColumnDescricao TEXT NOT NULL,
  $kTableAlbumColumnCapa TEXT NOT NULL,
  $kTableAlbumColumnPosicoes INTEGER NOT NULL,
  $kTableAlbumColumnCriacao TEXT NOT NULL,
  $kTableAlbumColumnTemaCor INTEGER NOT NULL
);
""";

const String kQueryAlbum = """
  SELECT
      a.*,
       COUNT(s.id) AS qtd_Albuns,
    SUM(CASE WHEN s.quantidade >= 1 THEN 1 ELSE 0 END) AS $kAlbumQuantidadeFigurinhas
    
FROM 
    $kTableNameAlbum a
LEFT JOIN 
    $kTableNameSticker s ON a.$kTableAlbumColumnId = s.$kTableStickerColumnIdAlbum
GROUP BY 
      a.$kTableAlbumColumnId;

  """;
