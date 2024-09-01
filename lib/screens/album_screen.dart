import 'dart:io';

import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../formularios/album_form.dart';
import '../preferencias.dart';
import '../repositories/album_repository.dart';
import '../utils/capturar_imagem.dart';
import '../utils/opcoes_cores.dart';
import '../widgets/album_design.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final teste = CapturarImagem(pasta: 'album', prefixo: 'capa');

  bool isBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    final preferencias = context.watch<Preferencias>();
    final albumR = context.watch<AlbumRepository>();
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        title: const Text('Meus Álbuns'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              preferencias.getTema
                  ? PhosphorIconsRegular.sun
                  : PhosphorIconsRegular.moon,
            ),
            onPressed: () {
              preferencias.setTema(preferencias.getTema ? false : true);
            },
          ),
        ],
      ),
      body: Consumer<AlbumRepository>(builder: (context, albumR, _) {
        return Column(
          children: [
            albumR.getAlbums.isEmpty
                ? const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                          'Vocé ainda não possui nenhum álbum! ☺️\n Mas pode criar um tocando em "Criar um álbum"!'),
                    ),
                  ),
                )
                : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2,
                    ),
                    itemCount: albumR.getAlbums.length,
                    itemBuilder: (context, index) {
                      return AlbumDesign(album: albumR.getAlbums[index]);
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                  ),
                ),
            Column(
              children: [
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: const Text(
                    'Adicionar um álbum',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    albumR.setForm(
                      form: true,
                      editar: false,
                      album: null,
                    );
                  },
                ),
              ],
            )
          ],
        );
      }),
      bottomSheet: albumR.isForm
          ? AlbumForm(
              album: albumR.isEdit ? albumR.selecionadoAlbumEdit : null,
              albumR: albumR)
          : null,
    );
  }
}
