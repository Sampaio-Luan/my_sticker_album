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
            left: BorderSide(width: 15, color: cor.cores[album.temaCor]),
            right: BorderSide(width: 0.1, color: cor.cores[album.temaCor]),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              child: album.capa.isEmpty
                  ? const Icon(Icons.image)
                  : Image.network(album.capa, fit: BoxFit.cover),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      album.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: cor.cores[album.temaCor].withAlpha(180),
                      ),
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                    Text(album.criacao),
                    Text(album.temaCor.toString()),
                    //Text(album.id.toString()),
                    Text(
                      album.capa,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(album.descricao),
                    Text(album.posicoes.toString()),
                    //Text(album.quantidadeFigurinhas.toString()),
                  ],
                ),
              ),
            ),
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
