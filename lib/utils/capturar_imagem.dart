import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'lista_de_cores.dart';

class CapturarImagem {
  File? imagem;
  final corD = CoresDeDestaque();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> capturarImagem() async {
    return "";
  }

  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  void opcoesCaptura(BuildContext context, int cor) {
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
                    backgroundColor: corD.cores[cor].withAlpha(30),
                    child: Center(
                      child: Icon(
                        PhosphorIconsRegular.image,
                        color: corD.cores[cor],
                      ),
                    ),
                  ),
                  title: Text(
                    'Galeria',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Buscar imagem da galeria
                    pick(ImageSource.gallery);
                  },
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: corD.cores[cor].withAlpha(30),
                    child: Center(
                      child: Icon(
                        PhosphorIconsRegular.camera,
                        color: corD.cores[cor],
                      ),
                    ),
                  ),
                  title: Text(
                    'Câmera',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Fazer foto da câmera
                    pick(ImageSource.camera);
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
