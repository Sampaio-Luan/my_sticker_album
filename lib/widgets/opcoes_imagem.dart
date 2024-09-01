import 'package:flutter/material.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/lista_de_cores.dart';

class OpcoesImagem extends StatelessWidget {
  Widget child;
  bool todasOp;
  int cor;
  OpcoesImagem(
      {super.key,
      required this.child,
      required this.todasOp,
      required this.cor});
  static List<String> titulos = [
    'Câmera',
    'Galeria',
    'Editar',
    'Excluir',
  ];
  static List<IconData> icones = [
    PhosphorIconsRegular.camera,
    PhosphorIconsRegular.image,
    PhosphorIconsRegular.pencilLine,
    PhosphorIconsRegular.trash
  ];
  final CoresDeDestaque cores = CoresDeDestaque();

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      blurSize: 5.0,
      menuItemExtent: 45,
      menuBoxDecoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: const Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: cores.cores[cor]['corDestaque']!.withAlpha(100),
      openWithTap: true, // Open Focused-Menu on Tap rather than Long Press
      menuOffset: 10.0, // Offset value to show menuItem from the selected item
      bottomOffsetHeight:
          80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
      menuItems: <FocusedMenuItem>[
        // Add Each FocusedMenuItem  for Menu Options
        FocusedMenuItem(
            title: Text(titulos[0]),
            trailingIcon: Icon(
              icones[0],
              color: cores.cores[cor]['corDestaque'],
            ),
            onPressed: () {}),
        FocusedMenuItem(
            title: const Text("Share"),
            trailingIcon: const Icon(Icons.share),
            onPressed: () {}),
        FocusedMenuItem(
            title: const Text("Favorite"),
            trailingIcon: const Icon(Icons.favorite_border),
            onPressed: () {}),
        FocusedMenuItem(
            title: const Text(
              "Delete",
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {}),
      ],
      onPressed: () {},
      child: child,
    );
  }
}
