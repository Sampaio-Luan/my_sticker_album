import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../preferencias.dart';
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
    final stickerR = context.watch<StickerRepository>();
    final preferencias = context.read<Preferencias>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cor.cores[widget.album.temaCor],
        title: Text(
          widget.album.nome,
        ),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              preferencias.setGradeView(preferencias.getGradeView == 2 ? 3 : 2);
            },
            icon: Icon(
              preferencias.getGradeView == 2
                  ? PhosphorIconsRegular.gridFour
                  : PhosphorIconsRegular.gridNine,
            ),
          ),
        ],
      ),
      body: Column(children: [
        StickerFiltro(album: widget.album),
        const Divider(height: 0, thickness: 0.5),
        stickerR.stickersInterface.isEmpty
            ? const Center(
                child: Text('Nenhum sticker encontrado.'),
              )
            : const SizedBox(height: 10),
        Expanded(
          child: Consumer<StickerRepository>(
            builder: (context, stickerR, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: preferencias.getGradeView,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: stickerR.stickersInterface.length,
                  itemBuilder: (context, index) {
                    return StickerDesign(
                      sticker: stickerR.stickersInterface[index],
                      album: widget.album,
                      index: index,
                    );
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
