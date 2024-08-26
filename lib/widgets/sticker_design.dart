import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../models/sticker.module.dart';
import '../preferencias.dart';
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

  ButtonStyle getButtonStyle(context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(cor.cores[widget.album.temaCor]),
      foregroundColor:
          WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      elevation: WidgetStateProperty.all(0),
    );
  }

  cardComImagem(StickerModel sticker) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: cor.cores[corTema],
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
                  child: Image.network(
                    widget.sticker.imagem,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 5,
                  child: Text(
                    '${widget.sticker.posicao}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
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
                    setState(() {
                      widget.sticker.quantidade--;
                    });
                  },
                  icon: Icon(
                    PhosphorIconsBold.minus,
                    size: 14,
                    shadows: [Shadow(color: cor.cores[corTema], blurRadius: 2)],
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
                    setState(() {
                      widget.sticker.quantidade++;
                    });
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
    final captura = CapturarImagem();
    final preferencia = Provider.of<Preferencias>(context, listen: false);
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.1,
              color: cor.cores[corTema],
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Icon(
                  PhosphorIconsBold.camera,
                  color: cor.cores[corTema].withAlpha(60),
                  size: preferencia.getGradeView == 2 ? 90 : 50,
                ),
                Positioned(
                  top: 1,
                  right: 2,
                  child: Text(
                    '${widget.sticker.posicao}',
                    style: TextStyle(
                      color: cor.cores[corTema].withAlpha(60),
                      fontSize:  preferencia.getGradeView == 2 ? 40 : 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          captura.opcoesCaptura(context, corTema);
        });
  }
}
