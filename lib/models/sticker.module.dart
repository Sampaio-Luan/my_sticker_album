class StickerModel {
  int id;
  int idAlbum;
  String url;
  int posicao;
  int quantidade;
  

  StickerModel({
    required this.id,
    required this.idAlbum,
    required this.url,
    required this.posicao,
    required this.quantidade,

  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idAlbum': idAlbum});
    result.addAll({'url': url});
    result.addAll({'posicao': posicao});
    result.addAll({'quantidade': quantidade});

    return result;
  }

  factory StickerModel.fromMap(Map<String, dynamic> map) {
    return StickerModel(
      id: map['id']?.toInt() ?? 0,
      idAlbum: map['idAlbum']?.toInt() ?? 0,
      url: map['url'] ?? '',
      posicao: map['posicao']?.toInt() ?? 0,
      quantidade: map['quantidade']?.toInt() ?? 0,
    );
  }
}
