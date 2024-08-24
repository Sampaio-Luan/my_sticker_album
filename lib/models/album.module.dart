class AlbumModel {
  int id;
  String nome;
  String descricao;
  String url;
  int posicoes;
  String criacao;

  AlbumModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.url,
    required this.posicoes,
    required this.criacao,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nome': nome});
    result.addAll({'descricao': descricao});
    result.addAll({'url': url});
    result.addAll({'posicoes': posicoes});
    result.addAll({'criacao': criacao});

    return result;
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map['id']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      url: map['url'] ?? '',
      posicoes: map['posicoes']?.toInt() ?? 0,
      criacao: map['criacao'] ?? '',
    );
  }
}
