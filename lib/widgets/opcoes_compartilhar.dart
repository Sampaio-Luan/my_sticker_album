import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../repositories/sticker_repository.dart';
import '../services/compartilhar.dart';
import '../utils/lista_de_cores.dart';

class OpcoesCompartilhar extends StatelessWidget {
  int cor;
  final CoresDeDestaque cores = CoresDeDestaque();
  List<String> opcoes = ['Todas', 'Repetidas', 'Faltantes'];
  Compartilhar compartilhar = Compartilhar();

  OpcoesCompartilhar({super.key, required this.cor});

  @override
  Widget build(BuildContext context) {
    final StickerRepository stickerR = context.read<StickerRepository>();
    return PopupMenuButton(
        elevation: 0,
        position: PopupMenuPosition.under,
        icon: Icon(
          PhosphorIconsRegular.shareNetwork,
          color: cores.cores[cor]['corFonte']!,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
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
            ),
            PopupMenuItem(
              value: 0,
              child: ListTile(
                leading: Icon(
                  PhosphorIconsRegular.stack,
                  color: cores.cores[cor]['corDestaque']!,
                ),
                title: Text(
                  'Todas',
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
                  PhosphorIconsRegular.stackPlus,
                  color: cores.cores[cor]['corDestaque']!,
                ),
                title: Text(
                  'Repetidas',
                  style: TextStyle(
                      color: cores.cores[cor]['corDestaque']!,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: ListTile(
                leading: Icon(
                  PhosphorIconsRegular.stackMinus,
                  color: cores.cores[cor]['corDestaque']!,
                ),
                title: Text(
                  'Faltantes',
                  style: TextStyle(
                      color: cores.cores[cor]['corDestaque']!,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ];
        },
        onSelected: (value) {
          switch (value) {
            case 0:
              compartilhar.compartilharFigurinhasTexto(stickerR.getStickers, opcoes[0]);
              break;
            case 1:
            compartilhar.compartilharFigurinhasTexto(stickerR.getStickers, opcoes[1]);
              break;
            case 2:
            compartilhar.compartilharFigurinhasTexto(stickerR.getStickers, opcoes[2]);
              break;
          }
        });
  }
}
