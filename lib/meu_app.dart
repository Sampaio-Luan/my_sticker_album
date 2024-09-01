import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'preferencias.dart';
import 'screens/album_screen.dart';
import 'screens/tela_espera.dart';
import 'themes/theme.dart';
import 'utils/util.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final preferencias = context.watch<Preferencias>();

    TextTheme textTheme =
        createTextTheme(context, "ABeeZee", "Noto Sans Javanese");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: preferencias.getTema ? theme.dark() : theme.light(),
      home:preferencias.carregado ? const AlbumScreen() : const TelaEspera(),
      debugShowCheckedModeBanner: false,
    );
  }
}
