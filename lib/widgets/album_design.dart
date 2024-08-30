import 'dart:io';

import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../repositories/album_repository.dart';
import '../screens/stickers_screen.dart';
import '../utils/capturar_imagem.dart';
import '../utils/lista_de_cores.dart';

class AlbumDesign extends StatelessWidget {
  final AlbumModel album;
  final cor = CoresDeDestaque();
  final capturar = CapturarImagem(pasta: 'album', prefixo: 'capa');
  TextEditingController imagem = TextEditingController();
  AlbumDesign({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final albumR = context.watch<AlbumRepository>();
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(
              width: 0.1,
              color: cor.cores[album.temaCor]['corDestaque']!,
            ),
            bottom: BorderSide(
              width: 0.1,
              color: cor.cores[album.temaCor]['corDestaque']!,
            ),
            left: BorderSide(
              width: 15,
              color: cor.cores[album.temaCor]['corDestaque']!,
            ),
            right: BorderSide(
              width: 0.1,
              color: cor.cores[album.temaCor]['corDestaque']!,
            ),
          ),
        ),
        child: Row(
          children: [
            album.capa.isEmpty
                ? Expanded(
                    flex: 3,
                    child: InkWell(
                      child: SizedBox.expand(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsRegular.camera,
                                color: cor.cores[album.temaCor]['corDestaque']!
                                    .withAlpha(190),
                                size: 70,
                              ),
                              Text(
                                'Toque aqui para adicionar uma capa',
                                style: TextStyle(
                                    color: cor.cores[album.temaCor]
                                            ['corDestaque']!
                                        .withAlpha(190)),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                      onTap: () {
                        capturar.opcoesCaptura(
                            context, album.temaCor, albumR, album, null, null);
                        album.capa = imagem.text;
                        albumR.atualizar(album);
                      },
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: SizedBox.expand(
                      child: Image.file(
                        File(album.capa),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left : 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      album.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: cor.cores[album.temaCor]['corDestaque']!
                            .withAlpha(180),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(album.criacao),
                    Text(album.descricao),
                    Text(
                      album.capa,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(album.id.toString()),
                        Text(album.posicoes.toString()),
                        Text(album.quantidadeFigurinhas.toString()),
                        Text(album.temaCor.toString()),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('id'),
                        Text('pos'),
                        Text('fig'),
                        Text('cor'),
                      ],
                    ),
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
