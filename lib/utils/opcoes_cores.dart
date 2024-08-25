import 'package:flutter/material.dart';

import 'lista_de_cores.dart';

class OpcoesCores {
  CoresDeDestaque cor = CoresDeDestaque();

  opcoesCores(context) async {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text(
              'Selecione uma cor',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.7,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: cor.cores.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, cor.cores[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cor.cores[index],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: cor.cores[index])],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10),
              ),
            ),
          );
        });
  }
}
