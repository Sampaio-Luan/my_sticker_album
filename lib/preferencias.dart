import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'repositories/album_repository.dart';

class Preferencias extends ChangeNotifier {
  late final SharedPreferences _prefs;

  bool _isTemaEscuro = false;
  get getTema => _isTemaEscuro;

  int _gradeView = 2;
  get getGradeView => _gradeView;

  bool carregado = false;

  Preferencias(AlbumRepository ?album) {
    _iniciaPreferencias(album);
  }

  _iniciaPreferencias(AlbumRepository ?album) async {
    _prefs = await SharedPreferences.getInstance();
    _isTemaEscuro = _prefs.getBool('isTemaEscuro') ?? false;
    _gradeView = _prefs.getInt('gradeView') ?? 2;
    esperar(album!);
  }

  setTema(bool value) async {
    _prefs.setBool('isTemaEscuro', _isTemaEscuro);
    _isTemaEscuro = value;
    debugPrint('📲😎Pref, setTema(): $_isTemaEscuro');
    notifyListeners();
  }

  setGradeView(int grade) async {
    _gradeView = grade;
    _prefs.setInt('gradeView', _gradeView);
    debugPrint('📲😎Pref, setTema(): $_isTemaEscuro');
    notifyListeners();
  }

  esperar(AlbumRepository album) async {
    await album.recuperar();
    debugPrint('📲😎Pref, esperar()');
    // Future.delayed(const Duration(seconds: 2), () {
    //   carregado = true;
    //   notifyListeners();
    // });
carregado = true;
    notifyListeners();
  }
}
