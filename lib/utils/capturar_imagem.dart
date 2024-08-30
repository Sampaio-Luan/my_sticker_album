import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/album.module.dart';
import '../models/sticker.module.dart';
import '../repositories/album_repository.dart';
import '../repositories/sticker_repository.dart';
import 'lista_de_cores.dart';

class CapturarImagem {
  File? imagem;
  final corD = CoresDeDestaque();
  final imagePicker = ImagePicker();
  File? imageFile;
  String pasta;
  String prefixo;

  CapturarImagem({required this.pasta, required this.prefixo});

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      String sd = await saveImage(imageFile!.readAsBytesSync());
      
      return sd;
    }
  }

  Future<String> saveImage(Uint8List imageBytes) async {
    String carimbo = DateFormat('dd/MM/yyyy HH:mm:ss')
        .format(DateTime.now())
        .replaceAll(' ', '')
        .replaceAll('/', '')
        .replaceAll(':', '')
        .replaceAll('.', '');
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$pasta';
    final imageFile = File('$imagePath/$prefixo$carimbo.jpg');

    await Directory(imagePath).create(recursive: true);
    await imageFile.writeAsBytes(imageBytes);
    debugPrint('Deu certo: ${imageFile.path}');
    return imageFile.path;
  }

  deletar(String dir) async {
    Directory? diretorio = await getExternalStorageDirectory();
    if (diretorio != null) {
      debugPrint(diretorio.path);
      File fileteste = File(dir);
      await fileteste.delete();
      debugPrint(fileteste.path);
    }
  }

  opcoesCaptura(
    BuildContext context,
    int cor,
    AlbumRepository ? albumR,
    AlbumModel ? albumM,
    StickerModel ? stickerM,
    StickerRepository ? stickerR,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: Row(children: [
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        corD.cores[cor]['corDestaque']!.withAlpha(30),
                    child: Center(
                      child: Icon(
                        PhosphorIconsRegular.image,
                        color: corD.cores[cor]['corDestaque'],
                      ),
                    ),
                  ),
                  title: Text(
                    'Galeria',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () async{
                    String caminho = await pick(ImageSource.gallery);
                    if (albumM != null) {
                      albumM.capa = caminho;
                      albumR!.atualizar(albumM);
                    }
                    else  {
                      stickerM!.imagem = caminho;
                      stickerR!.atualizar(stickerM);
                    }
                    
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        corD.cores[cor]['corDestaque']!.withAlpha(30),
                    child: Center(
                      child: Icon(
                        PhosphorIconsRegular.camera,
                        color: corD.cores[cor]['corDestaque'],
                      ),
                    ),
                  ),
                  title: Text(
                    'Câmera',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () async{
                    String caminho = await pick(ImageSource.gallery);
                    if (albumM != null) {
                      albumM.capa = caminho;
                      albumR!.atualizar(albumM);
                    }
                    else  {
                      stickerM!.imagem = caminho;
                      stickerR!.atualizar(stickerM);
                    }
                    
                    Navigator.of(context).pop();
                  },
                ),
              ),
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundColor: Colors.grey[200],
              //     child: Center(
              //       child: Icon(
              //         PhosphorIconsRegular.trash,
              //         color: Colors.grey[500],
              //       ),
              //     ),
              //   ),
              //   title: Text(
              //     'Remover',
              //     style: Theme.of(context).textTheme.bodyLarge,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     // Tornar a foto null

              //     imageFile = null;
              //   },
              // ),
            ]),
          ),
        );
      },
    );
  }
}
