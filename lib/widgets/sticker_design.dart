import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pro_image_editor/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/modules/main_editor/main_editor.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../models/sticker.module.dart';
import '../preferencias.dart';
import '../repositories/album_repository.dart';
import '../repositories/sticker_repository.dart';
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
  static List<String> titulos = [
    'Câmera',
    'Galeria',
    'Editar',
    'Excluir',
  ];
  static List<IconData> icones = [
    PhosphorIconsRegular.camera,
    PhosphorIconsRegular.image,
    PhosphorIconsRegular.pencilLine,
    PhosphorIconsRegular.trash
  ];

  final capturar = CapturarImagem(pasta: 'stickers', prefixo: 'stk');
  @override
  void initState() {
    super.initState();
    corTema = widget.album.temaCor;
    qtd = widget.sticker.quantidade;
  }

  @override
  Widget build(BuildContext context) {
    final preferencias = context.watch<Preferencias>();
    final stickerR = context.watch<StickerRepository>();
    final albumR = context.watch<AlbumRepository>();
    return FocusedMenuHolder(
      menuWidth: preferencias.getGradeView == 2
          ? MediaQuery.of(context).size.width * 0.45
          : MediaQuery.of(context).size.width * 0.30,
      blurSize: 5.0,
      menuItemExtent: 45,
      menuBoxDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: const Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: null,
      openWithTap: true, // Open Focused-Menu on Tap rather than Long Press
      menuOffset: 10.0, // Offset value to show menuItem from the selected item
      bottomOffsetHeight:
          80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
      menuItems: menuItems(preferencias, stickerR, context),
      onPressed: () {},
      child: card(widget.sticker, context),
    );
  }

  List<FocusedMenuItem> menuItems(
      Preferencias preferencias, StickerRepository stickerR, context) {
    List<FocusedMenuItem> menus = [
      FocusedMenuItem(
        title: Text(
          titulos[0],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          icones[0],
          color: cor.cores[corTema]['corDestaque'],
        ),
        onPressed: () async {
          String? path = await capturar.pick(
            ImageSource.camera,
            widget.sticker.imagem.isNotEmpty,
            widget.sticker.imagem,
          );
          if (path != null) {
            widget.sticker.imagem = path;
            stickerR.atualizar(widget.sticker);

            final editedImage = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProImageEditor.file(
                  File(widget.sticker.imagem),
                  callbacks: ProImageEditorCallbacks(
                    onImageEditingComplete: (Uint8List bytes) async {
                      widget.sticker.imagem = await capturar.saveEditedImage(
                          widget.sticker.imagem, bytes);
                      await stickerR.atualizar(widget.sticker);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
            debugPrint('editado $editedImage');
          }
        },
      ),
      FocusedMenuItem(
        title: Text(
          titulos[1],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          icones[1],
          color: cor.cores[corTema]['corDestaque'],
        ),
        onPressed: () async {
          String? path = await capturar.pick(
            ImageSource.gallery,
            widget.sticker.imagem.isNotEmpty,
            widget.sticker.imagem,
          );
          if (path != null) {
            widget.sticker.imagem = path;
            stickerR.atualizar(widget.sticker);
            setState(() {
              widget.sticker.imagem = path;
            });
          }
        },
      ),
      FocusedMenuItem(
          title: Text(
            titulos[2],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
          trailingIcon: Icon(
            icones[2],
            color: cor.cores[corTema]['corDestaque'],
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProImageEditor.file(
                  File(widget.sticker.imagem),
                  callbacks: ProImageEditorCallbacks(
                    onImageEditingComplete: (Uint8List bytes) async {
                      widget.sticker.imagem = await capturar.saveEditedImage(
                          widget.sticker.imagem, bytes);
                      await stickerR.atualizar(widget.sticker);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );

            //  final img = File(widget.sticker.imagem).readAsBytesSync();
            //   final editedImage = await Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ImageEditor(
            //         image: img, // <-- Uint8List of image

            //       ),
            //     ),
            //   );
            // debugPrint('editado $editedImage');
            // if (editedImage != null) {
            //   widget.sticker.imagem = await capturar.saveEditedImage(
            //       widget.sticker.imagem, editedImage);
            //   await stickerR.atualizar(widget.sticker);
            // }
          }),
      FocusedMenuItem(
        title: Text(
          titulos[3],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          icones[3],
          color: cor.cores[corTema]['corDestaque'],
        ),
        onPressed: () {
          capturar.deletar([widget.sticker.imagem]);
          widget.sticker.imagem = '';
          stickerR.atualizar(widget.sticker);
          // setState(() {
          //   widget.sticker.imagem = '';
          // });
        },
      ),
    ];
    return widget.sticker.imagem.isEmpty ? menus.sublist(0, 2) : menus;
  }

  card(StickerModel sticker, context) {
    final preferencia = Provider.of<Preferencias>(context, listen: false);
    final stickerR = Provider.of<StickerRepository>(context, listen: true);
    final albumR = Provider.of<AlbumRepository>(context, listen: true);
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
            child: sticker.imagem.isEmpty
                ? semImagem(sticker, context)
                : Stack(fit: StackFit.passthrough, children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.file(
                        width: double.maxFinite,
                        height: double.maxFinite,
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
                      if (widget.sticker.quantidade == 0) {
                        widget.album.quantidadeFigurinhas--;
                        albumR.addOrRemoveSticker(widget.album);
                      }
                    }
                  },
                  icon: Icon(
                    PhosphorIconsBold.minus,
                    color: cor.cores[corTema]['corDestaque']!,
                    size: 14,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                      )
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
                      if (widget.sticker.quantidade == 1) {
                        widget.album.quantidadeFigurinhas++;
                        albumR.addOrRemoveSticker(widget.album);
                      }
                    }
                  },
                  icon: Icon(
                    PhosphorIconsBold.plus,
                    color: cor.cores[corTema]['corDestaque']!,
                    size: 14,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                      )
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

  semImagem(StickerModel sticker, context) {
    final preferencia = Provider.of<Preferencias>(context, listen: false);

    return Padding(
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
    );
  }
}
