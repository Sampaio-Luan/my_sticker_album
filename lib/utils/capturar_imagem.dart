import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'lista_de_cores.dart';

class CapturarImagem {
  File? imagem;
  final corD = CoresDeDestaque();
  final imagePicker = ImagePicker();
  File? imageFile;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    //await requestPermissions();
    //await checkFilePermissions();
    //debugPrint('caminho da imagem: ${pickedFile?.path}');
    //debugPrint('diretorio padrao: ${await _localPath}');

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      // await FileSaver.instance
      //     .saveFile(
      //       name: 'image1',
      //       ext: 'png',
      //       mimeType: MimeType.png,
      //       filePath: imageFile!.path,
      //       file: imageFile!,
      //     )
      //     .then((value) => debugPrint(value));
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   await Permission.storage.request();
      //   //saveImage(pickedFile);

      // }
      saveImage(imageFile!.readAsBytesSync());
    }
  }

  teste(File imagemEscolhida) async {
    await requestPermissions();
    Directory? diretorio = await getExternalStorageDirectory();
    //await checkFilePermissions();
    debugPrint('caminho da imagem: ${imagemEscolhida.path}');
    if (diretorio != null) {
      debugPrint(diretorio.path);
      File fileteste = File(join(diretorio.path, imagemEscolhida.path));
      await fileteste.writeAsBytes(imagemEscolhida.readAsBytesSync());
      debugPrint(fileteste.path);
    }
  }

  // Future<void> saveImage(XFile image) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final String path = '${directory.path}/${image.name}';
  //   final File newImage = File(path);
  //   await newImage.writeAsBytes(await image.readAsBytes());
  // }

  Future<String> saveImage(Uint8List imageBytes) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/images';
    final imageFile = File('$imagePath/image.jpg');

    await Directory(imagePath).create(recursive: true);
    await imageFile.writeAsBytes(imageBytes);
    debugPrint('DEu certo: ${imageFile.path}');
    return imageFile.path;
  }

  deletar() async {
    Directory? diretorio = await getExternalStorageDirectory();
    if (diretorio != null) {
      debugPrint(diretorio.path);
      File fileteste = File(join(diretorio.path, 'images','image.jpg'));
      await fileteste.delete();
      debugPrint(fileteste.path);
    }
  }

  requestPermissions() async {
    // Solicitar permissão para a câmera
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
      debugPrint(status.toString());
    }

    // Solicitar permissão para a localização
    status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
      debugPrint(status.toString());
    }

    // Solicitar permissão para o armazenamento
    status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      debugPrint(status.toString());
    }

    status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    status = await Permission.mediaLibrary.status;
    if (!status.isGranted) {
      await Permission.mediaLibrary.request();
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
