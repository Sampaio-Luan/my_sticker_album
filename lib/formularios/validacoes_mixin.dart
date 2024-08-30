import 'package:flutter/material.dart';

import '../utils/lista_de_cores.dart';

mixin ValidacoesMixin {
  final corD = CoresDeDestaque();
  String? preenchimentoObrigatorio(
      {required String? input, required String? message}) {
    if (input!.isEmpty) return message ?? 'Preenchimento obrigatório';
    return null;
  }

  isValidado({
    required BuildContext context,
    required GlobalKey<FormState> formularioKey,
    required String mensagem,
    required int cor,
  }) {
    if (formularioKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: corD.cores[cor]['corDestaque']!.withAlpha(200),

          content: Text(
            mensagem,
            style: TextStyle(
              fontSize: 16,
              color: corD.cores[cor]['corFonte']!,
            ),
          ),
          duration: const Duration(seconds: 2), // Defina o tempo desejado
        ),
      );
      return 0;
    }
  }
}
