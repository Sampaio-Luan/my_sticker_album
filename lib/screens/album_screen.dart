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
  final teste = CapturarImagem();

  bool isBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    final preferencias = context.watch<Preferencias>();
    final albumR = context.watch<AlbumRepository>();
    return SafeArea(
      child: Scaffold(
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
          return albumR.getAlbums.isEmpty
              ? const Center(
                  child: Text('Nenhum álbum encontrado'),
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
       // bottomSheet: albumR.isForm ?  AlbumForm(album: null, albumR: albumR) : null,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showModalBottomSheet(
            //     context: context,
            //     builder: (context) =>
            //         const AlbumForm(album: null));
            //albumR.setForm(true);
            //b.opcoesCores(context, albumR);
            //teste.opcoesCaptura(context, 1);
            teste.deletar();
            //teste.checkFilePermissions();
            //teste.requestPermissions();
          },
          //null,

          //   teste.localPath.then((value) => debugPrint(value));
          // },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
