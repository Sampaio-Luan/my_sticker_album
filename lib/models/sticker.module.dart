import '../constants/k_tb_sticker.dart';
class StickerModel {
  int id;
  int idAlbum;
  String imagem;
  int posicao;
  int quantidade;
  String nome;
  String descricao;
  

  StickerModel({
    required this.id,
    required this.idAlbum,
    required this.imagem,
    required this.posicao,
    required this.quantidade,
    required this.nome,
    required this.descricao,

  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({kTableStickerColumnIdAlbum: idAlbum});
    result.addAll({kTableStickerColumnImagem: imagem});
    result.addAll({kTableStickerColumnPosicao: posicao});
    result.addAll({kTableStickerColumnQuantidade: quantidade});
    result.addAll({kTableStickerColumnNome: nome});
    result.addAll({kTableStickerColumnDescricao: descricao});

    return result;
  }

  factory StickerModel.fromMap(Map<String, dynamic> map) {
    return StickerModel(
      id: map[kTableStickerColumnId]?.toInt() ?? 0,
      idAlbum: map[kTableStickerColumnIdAlbum]?.toInt() ?? 0,
      imagem: map[kTableStickerColumnImagem] ?? '',
      posicao: map[kTableStickerColumnPosicao]?.toInt() ?? 0,
      quantidade: map[kTableStickerColumnQuantidade]?.toInt() ?? 0,
      nome: map[kTableStickerColumnNome] ?? '',
      descricao: map[kTableStickerColumnDescricao] ?? '',
    );
  }
}
