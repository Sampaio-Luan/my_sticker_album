import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'meu_app.dart';
import 'repositories/album_repository.dart';
import 'repositories/sticker_repository.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlbumRepository()),
        ChangeNotifierProvider(create: (context) => StickerRepository()),
      ],
      child: const MeuApp(),
    ),
  );
}
