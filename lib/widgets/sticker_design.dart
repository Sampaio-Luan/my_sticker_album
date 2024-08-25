import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/album.module.dart';
import '../models/sticker.module.dart';
import '../utils/lista_de_cores.dart';

class StickerDesign extends StatefulWidget {
  final AlbumModel album;
  final int index;
  final StickerModel? sticker;
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
    qtd = widget.sticker != null ? widget.sticker!.quantidade : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(width: 0.1, color: cor.cores[corTema]),
          bottom: BorderSide(width: 0.1, color: cor.cores[corTema]),
          left: BorderSide(width: 0.1, color: cor.cores[corTema]),
          right: BorderSide(width: 0.1, color: cor.cores[corTema]),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.index + 1}'),
            Text(widget.sticker != null
                ? widget.sticker!.posicao.toString()
                : 'nada'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  
                  style: getButtonStyle(context),
                  onPressed: widget.sticker != null
                      ? () {
                          setState(() {
                            qtd--;
                            debugPrint('Quantidade - $qtd');
                          });
                        }
                      : null,
                  icon: const Icon(PhosphorIconsBold.minus),
                ),
                Expanded(
                  child: Text(
                    '${widget.sticker != null ? qtd : 0}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                IconButton.filled(
                  style: getButtonStyle(context),
                  onPressed: widget.sticker != null
                      ? () {
                          setState(() {
                            qtd++;
                            debugPrint('Quantidade + $qtd');
                          });
                        }
                      : null,
                  icon: const Icon(PhosphorIconsBold.plus),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
