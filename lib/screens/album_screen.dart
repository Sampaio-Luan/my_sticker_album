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
  final teste = CapturarImagem(pasta : 'album', prefixo: 'capa');

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
          IconButton(
            icon: const Icon(
              PhosphorIconsRegular.listPlus,
            ),
            onPressed: () {
             albumR.setForm(true);
            },
          ),
        ],
      ),
      body: Consumer<AlbumRepository>(builder: (context, albumR, _) {
        return 
        // albumR.d.isEmpty ? const Center(
        //   child: Text('Vocé ainda não possui nenhum álbum! ☺️\n Mas pode criar um clicando no botão no canto superior direito!'),
        // ) : Image.file(File(albumR.d));
        
        albumR.getAlbums.isEmpty
            ? const Center(
                child: Text(
                    'Vocé ainda não possui nenhum álbum! ☺️\n Mas pode criar um clicando no botão no canto superior direito!'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 2,
                ),
                itemCount: albumR.getAlbums.length,
                itemBuilder: (context, index) {
                  return AlbumDesign(album: albumR.getAlbums[index]);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              );
      }),
      bottomSheet: albumR.isForm ?  AlbumForm(album: null, albumR: albumR) : null,
   
    );
  }
}
