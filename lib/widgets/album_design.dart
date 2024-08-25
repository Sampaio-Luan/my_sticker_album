import 'package:flutter/material.dart';

import '../models/album.module.dart';
import '../screens/stickers_screen.dart';
import '../utils/lista_de_cores.dart';

class AlbumDesign extends StatelessWidget {
  final AlbumModel album;
  final cor = CoresDeDestaque();
  AlbumDesign({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(width: 0.1, color: cor.cores[album.temaCor]),
            bottom: BorderSide(width: 0.1, color: cor.cores[album.temaCor]),
            left: BorderSide(width: 20, color: cor.cores[album.temaCor]),
            right: BorderSide(width: 0.1, color: cor.cores[album.temaCor]),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(album.nome),
            Text(album.criacao),
            Text(album.temaCor.toString()),
            Text(album.id.toString()),
            Text(album.capa),
            Text(album.descricao),
            Text(album.posicoes.toString()),
            Text(album.quantidadeFigurinhas.toString()),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StickersScreen(album: album),
          ),
        );
      },
    );
  }
}
