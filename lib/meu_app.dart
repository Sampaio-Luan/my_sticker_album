import 'package:flutter/material.dart';

import 'screens/album_screen.dart';
import 'themes/theme.dart';
import 'utils/util.dart';

class MeuApp extends StatelessWidget {
  
  const MeuApp({super.key});


  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme =
        createTextTheme(context, "ABeeZee", "Noto Sans Javanese");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const AlbumScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}









