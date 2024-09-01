import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'lista_de_cores.dart';

class CapturarImagem {
  File? imagem;
  final corD = CoresDeDestaque();
  final imagePicker = ImagePicker();
  File? imageFile;
  String pasta;
  String prefixo;

  CapturarImagem({required this.pasta, required this.prefixo});

  pick(ImageSource source, bool isEdit, String oldPath) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      String sd = '';
      imageFile = File(pickedFile.path);
      if (isEdit) {
        sd = await saveEditedImage(oldPath, imageFile!.readAsBytesSync());
      } else {
        sd = await saveImage(imageFile!.readAsBytesSync());
      }

      return sd;
    }
  }

  Future<String> saveImage(Uint8List imageBytes) async {
    String carimbo = carimboT();
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$pasta';
    final imageFile = File('$imagePath/$prefixo$carimbo.jpg');

    await Directory(imagePath).create(recursive: true);
    await imageFile.writeAsBytes(imageBytes);
    debugPrint('Salva imagem: ${imageFile.path}');
    return imageFile.path;
  }

  Future<String> saveEditedImage(String oldPath, Uint8List imageBytes) async {
    deletar([oldPath]);
    String carimbo = carimboT();
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$pasta';
    final imageFile = File('$imagePath/$prefixo$carimbo.jpg');

    await Directory(imagePath).create(recursive: true);
    await imageFile.writeAsBytes(imageBytes);
    debugPrint('Salva imagem editada: ${imageFile.path}');
    return imageFile.path;
  }

  deletar(List<String> dir) async {
    Directory? diretorio = await getExternalStorageDirectory();
    if (diretorio != null) {
      for (String d in dir) {
        debugPrint(d);
        File fileteste = File(d);
        await fileteste.delete();
        debugPrint('File deleted: ${fileteste.path}');
      }
    }
  }

  String carimboT() {
    String carimboD = DateFormat('dd/MM/yyyy HH:mm:ss')
        .format(DateTime.now())
        .replaceAll(' ', '')
        .replaceAll('/', '')
        .replaceAll(':', '')
        .replaceAll('.', '');

    return carimboD;
  }
}
