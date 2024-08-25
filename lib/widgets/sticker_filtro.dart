import 'package:flutter/material.dart';

import '../models/album.module.dart';
import '../utils/lista_de_cores.dart';

class StickerFiltro extends StatefulWidget {
  final AlbumModel album;
  const StickerFiltro({super.key, required this.album});

  @override
  State<StickerFiltro> createState() => _StickerFiltroState();
}

class _StickerFiltroState extends State<StickerFiltro> {
  final CoresDeDestaque cor = CoresDeDestaque();
  final List<String> tituloFiltros = ['Todos', 'Repitidos', 'Faltantes'];
  Set<String> selecionado = {};

  @override
  void initState() {
    selecionado.add(tituloFiltros[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
        style: const ButtonStyle(
          //backgroundColor: WidgetStateProperty.all(cor.cores[widget.album.temaCor]),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
        ),
        segments: [
          ButtonSegment(value: tituloFiltros[0], label: Text(tituloFiltros[0])),
          ButtonSegment(value: tituloFiltros[1], label: Text(tituloFiltros[1])),
          ButtonSegment(value: tituloFiltros[2], label: Text(tituloFiltros[2]))
        ],
        selected: selecionado,
        onSelectionChanged: (values) {
          setState(() {
            selecionado = values;
          });
        });
  }
}
