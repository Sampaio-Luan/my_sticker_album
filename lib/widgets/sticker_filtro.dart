import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../repositories/sticker_repository.dart';
import '../utils/lista_de_cores.dart';

class StickerFiltro extends StatefulWidget {
  final AlbumModel album;
  const StickerFiltro({super.key, required this.album});

  @override
  State<StickerFiltro> createState() => _StickerFiltroState();
}

class _StickerFiltroState extends State<StickerFiltro> {
  final CoresDeDestaque cor = CoresDeDestaque();
  final List<String> tituloFiltros = ['Todas', 'Repetidas', 'Faltantes'];
  String selecionado = 'Todas';

  @override
  Widget build(BuildContext context) {
    final stickerR = context.watch<StickerRepository>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListTile(
            title: Text(tituloFiltros[0], textAlign: TextAlign.center),
            tileColor: selecionado == tituloFiltros[0]
                ? cor.cores[widget.album.temaCor].withAlpha(200)
                : null,
            textColor: selecionado == tituloFiltros[0]
                ? Colors.white
                : null,
            onTap: () {
              stickerR.filtrar(tituloFiltros[0]);
              setState(() {
                selecionado = tituloFiltros[0];
              });
            },
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: ListTile(
            title: Text(tituloFiltros[1], textAlign: TextAlign.center),
            tileColor: selecionado == tituloFiltros[1]
                ? cor.cores[widget.album.temaCor].withAlpha(200)
                : null,
            textColor: selecionado == tituloFiltros[1]
                ? Colors.white
                : null,
            onTap: () {
              stickerR.filtrar(tituloFiltros[1]);
              setState(() {
                selecionado = tituloFiltros[1];
              });
            },
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(tituloFiltros[2], textAlign: TextAlign.center),
            tileColor: selecionado == tituloFiltros[2]
                ? cor.cores[widget.album.temaCor].withAlpha(200)
                : null,
            textColor: selecionado == tituloFiltros[2]
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
            onTap: () {
              stickerR.filtrar(tituloFiltros[2]);
              setState(() {
                selecionado = tituloFiltros[2];
              });
            },
          ),
        )
      ],
    );
  }
}
