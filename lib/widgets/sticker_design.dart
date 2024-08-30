import 'dart:io';

import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../models/sticker.module.dart';
import '../preferencias.dart';
import '../repositories/sticker_repository.dart';
import '../screens/visualizar_imagem.dart';
import '../utils/capturar_imagem.dart';
import '../utils/lista_de_cores.dart';

class StickerDesign extends StatefulWidget {
  final AlbumModel album;
  final int index;
  final StickerModel sticker;
  const StickerDesign(
      {super.key,
      required this.album,
      required this.index,
      required this.sticker});

  @override
  State<StickerDesign> createState() => _StickerDesignState();
}

class _StickerDesignState extends State<StickerDesign> {
  final CoresDeDestaque cor = CoresDeDestaque();
  int corTema = 0;
  int qtd = 0;

  @override
  void initState() {
    super.initState();
    corTema = widget.album.temaCor;
    qtd = widget.sticker.quantidade;
  }

  @override
  Widget build(BuildContext context) {
    return widget.sticker.imagem.isEmpty
        ? cardSemImagem(widget.sticker, context)
        : cardComImagem(widget.sticker);
  }

  cardComImagem(StickerModel sticker) {
    final preferencia = Provider.of<Preferencias>(context, listen: false);
    final stickerR = Provider.of<StickerRepository>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: cor.cores[corTema]['corDestaque']!,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: InkWell(
              child: Stack(fit: StackFit.passthrough, children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.file(
                    File(
                      widget.sticker.imagem,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 5,
                  child: Text(
                    '${widget.sticker.posicao}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: preferencia.getGradeView == 2 ? 23 : 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisualizarImagem(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  //style: getButtonStyle(context),
                  onPressed: () {
                    if (widget.sticker.quantidade == 0) {
                    } else {
                      widget.sticker.quantidade--;
                      stickerR.atualizar(widget.sticker);
                    }
                  },
                  icon: Icon(
                    PhosphorIconsBold.minus,
                    size: 14,
                    shadows: [
                      Shadow(
                          color: cor.cores[corTema]['corDestaque']!,
                          blurRadius: 2)
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '${widget.sticker.quantidade}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (widget.sticker.quantidade == 999) {
                    } else {
                      widget.sticker.quantidade++;
                      stickerR.atualizar(widget.sticker);
                    }
                  },
                  icon: const Icon(
                    PhosphorIconsBold.plus,
                    size: 14,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  cardSemImagem(StickerModel sticker, context) {
    final captura = CapturarImagem(pasta: 'stickers', prefixo: 'stk');
    final preferencia = Provider.of<Preferencias>(context, listen: false);
    final stickerR = Provider.of<StickerRepository>(context, listen: true);
    TextEditingController imagem = TextEditingController();
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.1,
              color: cor.cores[corTema]['corDestaque']!,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Icon(
                  PhosphorIconsRegular.camera,
                  color: cor.cores[corTema]['corDestaque']!.withAlpha(60),
                  size: preferencia.getGradeView == 2 ? 90 : 50,
                ),
                Positioned(
                  top: 1,
                  right: 2,
                  child: Text(
                    '${widget.sticker.posicao}',
                    style: TextStyle(
                      color: cor.cores[corTema]['corDestaque']!.withAlpha(60),
                      fontSize: preferencia.getGradeView == 2 ? 30 : 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          captura.opcoesCaptura(
              context, corTema, null, null, widget.sticker, stickerR);
          widget.sticker.imagem = imagem.text;
          stickerR.atualizar(widget.sticker);
        });
  }
}
