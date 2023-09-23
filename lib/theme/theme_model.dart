import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transportasi_11/Theme/theme_prefrences.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePrefrences _prefrences = ThemePrefrences();
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    _prefrences = ThemePrefrences();
    getPrefrences();
  }

  getPrefrences() async {
    _isDark = await _prefrences.getTheme();
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    _prefrences.setTheme(value);
    notifyListeners();
  }
}
