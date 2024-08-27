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
      //_saveImageToDisk(pickedFile.path);
      copiarImagem(pickedFile.path);
      debugPrint('Enviou a imagem para o copia');
      imageFile = File(pickedFile.path);
    }
  }

  _saveImageToDisk(String imageP) async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    final imagePath =
        '${directory.path}/$imageP'; // Caminho completo para a imagem
    debugPrint(imagePath);
    // Agora você pode salvar a imagem no caminho especificado
    // (por exemplo, usando o pacote http para baixar a imagem ou copiando-a de outro local).
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

  Future<void> copiarImagem(String diretorioOrigem) async {
    debugPrint('Entrou no copia');
    // Obter o caminho do diretório de origem
    //final diretorioOrigem = await getApplicationDocumentsDirectory();
    final caminhoOrigem = diretorioOrigem;
    debugPrint('pegou o caminho do copia');

    // Obter o caminho do diretório de destino
    final diretorioDestino = await getApplicationDocumentsDirectory();
    final caminhoDestino = '${diretorioDestino.path}/imagem.png';
    debugPrint('pegou o destino do copia');
    // Ler a imagem de origem
    final arquivoOrigem = File(caminhoOrigem);
    final bytes = await arquivoOrigem.readAsBytes();
    debugPrint('leu a imagem do copia');
    // Criar a imagem de destino e escrever os bytes
    final arquivoDestino = File(caminhoDestino);
    await arquivoDestino.writeAsBytes(bytes);
    debugPrint('escreveu a imagem do copia');

    debugPrint(arquivoDestino.path);
  }
}
