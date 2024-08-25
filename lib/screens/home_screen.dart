import 'package:flutter/material.dart';

import '../utils/capturar_imagem.dart';
import '../utils/opcoes_cores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final teste = CapturarImagem();
  final b =  OpcoesCores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        title: const Text('Meus Álbuns'),
        //centerTitle: true,
        elevation: 0,
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          b.opcoesCores(context);
          //teste.opcoesCaptura(context);
        },
        //null,

        //   teste.localPath.then((value) => debugPrint(value));
        // },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
