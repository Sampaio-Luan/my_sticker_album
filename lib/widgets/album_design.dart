import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../preferencias.dart';
import '../repositories/album_repository.dart';
import '../repositories/sticker_repository.dart';
import '../screens/stickers_screen.dart';
import '../utils/capturar_imagem.dart';
import '../utils/lista_de_cores.dart';

import 'opcoes_album.dart';

class AlbumDesign extends StatefulWidget {
  final AlbumModel album;

  const AlbumDesign({super.key, required this.album});
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

  @override
  State<AlbumDesign> createState() => _AlbumDesignState();
}

class _AlbumDesignState extends State<AlbumDesign> {
  final cor = CoresDeDestaque();

  final capturar = CapturarImagem(pasta: 'album', prefixo: 'capa');

  TextEditingController imagem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final albumR = context.watch<AlbumRepository>();
    final stickerR = context.watch<StickerRepository>();
    final preferencias = context.watch<Preferencias>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          top: BorderSide(
            width: 1.3,
            color: cor.cores[widget.album.temaCor]['corDestaque']!,
          ),
          bottom: BorderSide(
            width: 1.3,
            color: cor.cores[widget.album.temaCor]['corDestaque']!,
          ),
          left: BorderSide(
            width: 15,
            color: cor.cores[widget.album.temaCor]['corDestaque']!,
          ),
          right: BorderSide(
            width: 1.3,
            color: cor.cores[widget.album.temaCor]['corDestaque']!,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: FocusedMenuHolder(
              menuWidth: MediaQuery.of(context).size.width * 0.38,

              blurSize: 5.0,
              menuItemExtent: 45,
              menuBoxDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              duration: const Duration(milliseconds: 100),
              animateMenuItems: true,
              blurBackgroundColor: null,
              openWithTap:
                  true, // Open Focused-Menu on Tap rather than Long Press
              menuOffset:
                  10.0, // Offset value to show menuItem from the selected item
              bottomOffsetHeight:
                  80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
              menuItems: menuItems(preferencias, albumR, context),
              onPressed: () {},
              child: SizedBox.expand(
                child: widget.album.capa.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                              color: cor.cores[widget.album.temaCor]
                                      ['corDestaque']!
                                  .withAlpha(190),
                            ),
                            borderRadius: BorderRadius.circular(1),
                            image: const DecorationImage(
                              image: AssetImage(''),
                              fit: BoxFit.cover,
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsRegular.camera,
                                color: cor.cores[widget.album.temaCor]
                                        ['corDestaque']!
                                    .withAlpha(190),
                                size: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Toque aqui para adicionar uma imagem de capa',
                                  style: TextStyle(
                                      color: cor.cores[widget.album.temaCor]
                                              ['corDestaque']!
                                          .withAlpha(190)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                      )
                    : SizedBox.expand(
                        child: Image.file(
                          File(widget.album.capa),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.album.nome,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(200),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        OpcoesAlbum(
                            cor: widget.album.temaCor, album: widget.album),
                      ],
                    ),
                    Text(widget.album.criacao),
                    Expanded(child: Text(widget.album.descricao)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: indicador(
                            context,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.album.quantidadeFigurinhas}/${widget.album.posicoes}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () async {
                await stickerR.recuperar(widget.album.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StickersScreen(album: widget.album),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<FocusedMenuItem> menuItems(
      Preferencias preferencias, AlbumRepository albumR, context) {
    List<FocusedMenuItem> menus = [
      FocusedMenuItem(
        title: Text(
          AlbumDesign.titulos[0],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          AlbumDesign.icones[0],
          color: cor.cores[widget.album.temaCor]['corDestaque'],
        ),
        onPressed: () async {
          String? path = await capturar.pick(
            ImageSource.camera,
            widget.album.capa.isNotEmpty,
            widget.album.capa,
          );
          if (path != null) {
            widget.album.capa = path;
            albumR.atualizar(widget.album);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProImageEditor.file(
                  File(widget.album.capa),
                  callbacks: ProImageEditorCallbacks(
                    onImageEditingComplete: (Uint8List bytes) async {
                      widget.album.capa = await capturar.saveEditedImage(
                          widget.album.capa, bytes);
                      await albumR.atualizar(widget.album);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
            debugPrint('editado');
          }
        },
      ),
      FocusedMenuItem(
        title: Text(
          AlbumDesign.titulos[1],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          AlbumDesign.icones[1],
          color: cor.cores[widget.album.temaCor]['corDestaque'],
        ),
        onPressed: () async {
          String? path = await capturar.pick(
            ImageSource.gallery,
            widget.album.capa.isNotEmpty,
            widget.album.capa,
          );
          if (path != null) {
            widget.album.capa = path;
            albumR.atualizar(widget.album);
          }
        },
      ),
      FocusedMenuItem(
          title: Text(
            AlbumDesign.titulos[2],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
          trailingIcon: Icon(
            AlbumDesign.icones[2],
            color: cor.cores[widget.album.temaCor]['corDestaque'],
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProImageEditor.file(
                  File(widget.album.capa),
                  callbacks: ProImageEditorCallbacks(
                    onImageEditingComplete: (Uint8List bytes) async {
                      widget.album.capa = await capturar.saveEditedImage(
                          widget.album.capa, bytes);
                      await albumR.atualizar(widget.album);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          }),
      FocusedMenuItem(
        title: Text(
          AlbumDesign.titulos[3],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        trailingIcon: Icon(
          AlbumDesign.icones[3],
          color: cor.cores[widget.album.temaCor]['corDestaque'],
        ),
        onPressed: () {
          capturar.deletar([widget.album.capa]);
          widget.album.capa = '';
          albumR.atualizar(widget.album);
        },
      ),
    ];
    return widget.album.capa.isEmpty ? menus.sublist(0, 2) : menus;
  }

  indicador(context) {
    return LinearPercentIndicator(
      backgroundColor:
          cor.cores[widget.album.temaCor]['corDestaque']!.withAlpha(50),
      padding: EdgeInsets.zero,
      barRadius: const Radius.circular(5),
      lineHeight: 17.0,
      percent:
          widget.album.quantidadeFigurinhas / widget.album.posicoes * 100 / 100,
      center: Text(
        "${(widget.album.quantidadeFigurinhas / widget.album.posicoes * 100).toStringAsFixed(0)}%",
        style: const TextStyle(
          fontSize: 12.0,
        ),
      ),
      progressColor: cor.cores[widget.album.temaCor]['corDestaque'],
    );
  }
}
