import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../repositories/sticker_repository.dart';
import '../utils/lista_de_cores.dart';
import '../widgets/sticker_design.dart';
import '../widgets/sticker_filtro.dart';

class StickersScreen extends StatefulWidget {
  final AlbumModel album;
  const StickersScreen({super.key, required this.album});

  @override
  State<StickersScreen> createState() => _StickersScreenState();
}

class _StickersScreenState extends State<StickersScreen> {
  final CoresDeDestaque cor = CoresDeDestaque();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: cor.cores[widget.album.temaCor],
          title: Text(widget.album.nome),
        ),
        body: Column(
          children: [
            StickerFiltro(album: widget.album),
            Expanded(
              child: Consumer<StickerRepository>(
                builder: (context, stickerR, _) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: widget.album.posicoes,
                    itemBuilder: (context, index) {
                      if (stickerR.getStickers.isEmpty) {
                        return StickerDesign(
                          sticker: null,
                          album: widget.album,
                          index: index,
                        );
                      } else {
                        if (stickerR.posicoes.contains(index)) {
                          int a = stickerR.posicoes.indexOf(index);
                          return StickerDesign(
                            sticker: stickerR.getStickers[a],
                            album: widget.album,
                            index: index,
                          );
                        } else {
                          return StickerDesign(
                            sticker: null,
                            album: widget.album,
                            index: index,
                          );
                        }
                      }
                    },
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
