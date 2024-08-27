import 'package:flutter/material.dart';

import 'lista_de_cores.dart';

class OpcoesCores extends StatefulWidget {
  final int qtdElementLinha;
  final TextEditingController controle;
  const OpcoesCores(
      {super.key, required this.qtdElementLinha, required this.controle});

  @override
  State<OpcoesCores> createState() => _OpcoesCoresState();
}

class _OpcoesCoresState extends State<OpcoesCores> {
  final cor = CoresDeDestaque();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 4.0),
      child: SizedBox(
        //height: MediaQuery.of(context).size.height * 0.4,
        //width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.qtdElementLinha,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: cor.cores.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.controle.text = index.toString();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: cor.cores[index],
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: cor.cores[index])],
                ),
                child: int.parse(widget.controle.text) == index
                    ? Icon(Icons.check,
                        color: (index == 15 || index == 11)
                            ? Colors.black
                            : Colors.white)
                    : null,
              ),
            );
          },
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
        ),
      ),
    );
  }
}
