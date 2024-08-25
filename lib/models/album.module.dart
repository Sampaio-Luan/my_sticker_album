import '../constants/k_tb_album.dart';
class AlbumModel {
  int id;
  String nome;
  String descricao;
  String capa;
  int posicoes;
  String criacao;
  int temaCor;
  int quantidadeFigurinhas;
  

  AlbumModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.capa,
    required this.posicoes,
    required this.criacao,
    required this.temaCor,
    required this.quantidadeFigurinhas,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({kTableAlbumColumnNome: nome});
    result.addAll({kTableAlbumColumnDescricao: descricao});
    result.addAll({kTableAlbumColumnCapa: capa});
    result.addAll({kTableAlbumColumnPosicoes: posicoes});
    result.addAll({kTableAlbumColumnCriacao: criacao});
    result.addAll({kTableAlbumColumnTemaCor: temaCor});

    return result;
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map[kTableAlbumColumnId]?.toInt() ?? 0,
      nome: map[kTableAlbumColumnNome] ?? '',
      descricao: map[kTableAlbumColumnDescricao] ?? '',
      capa: map[kTableAlbumColumnCapa] ?? '',
      posicoes: map[kTableAlbumColumnPosicoes]?.toInt() ?? 0,
      criacao: map[kTableAlbumColumnCriacao] ?? '',
      temaCor: map[kTableAlbumColumnTemaCor]?.toInt() ?? 0,
      quantidadeFigurinhas: map[kAlbumQuantidadeFigurinhas]?.toInt() ?? 0,
    );
  }
}
