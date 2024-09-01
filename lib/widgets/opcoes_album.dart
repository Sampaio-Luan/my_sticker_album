import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../models/album.module.dart';
import '../repositories/album_repository.dart';
import '../utils/lista_de_cores.dart';

class OpcoesAlbum extends StatelessWidget {
  final int cor;
  AlbumModel album;
  final CoresDeDestaque cores = CoresDeDestaque();
  final List<String> titulos = ['Editar', 'Excluir', 'Tema'];
  OpcoesAlbum({super.key, required this.cor, required this.album});

  @override
  Widget build(BuildContext context) {
    final albumR = context.watch<AlbumRepository>();
    return PopupMenuButton(
      elevation: 0,
      position: PopupMenuPosition.under,
      icon: Icon(
        PhosphorIconsRegular.notePencil,
        color: cores.cores[cor]['corDestaque']!,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: ListTile(
              leading: Icon(
                PhosphorIconsRegular.pencilLine,
                color: cores.cores[cor]['corDestaque']!,
              ),
              title: Text(
                titulos[0],
                style: TextStyle(
                    color: cores.cores[cor]['corDestaque'],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: ListTile(
              leading: Icon(
                PhosphorIconsRegular.trash,
                color: cores.cores[cor]['corDestaque']!,
              ),
              title: Text(
                titulos[1],
                style: TextStyle(
                    color: cores.cores[cor]['corDestaque'],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: ListTile(
              leading: Icon(
                PhosphorIconsRegular.palette,
                color: cores.cores[cor]['corDestaque']!,
              ),
              title: Text(
                titulos[2],
                style: TextStyle(
                    color: cores.cores[cor]['corDestaque'],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ];
      },
      onSelected: (int value) {
        switch (value) {
          case 0:
          albumR.setForm(form: true, editar: true, album: album);
            
            break;
          case 1:
            albumR.deletar(album);
            break;
          case 2:
            
            break;
        }
      },
    );
  }

  PopupMenuItem item() {
    return PopupMenuItem(
      value: 4,
      child: Center(
        child: Text(
          'Compartilhar:',
          style: TextStyle(
            color: cores.cores[cor]['corDestaque'],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
