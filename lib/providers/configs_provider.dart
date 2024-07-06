import 'package:flutter/material.dart';

class ConfigsProvider with ChangeNotifier {
  bool isDark;
  String language;

  ConfigsProvider({this.isDark = false, this.language = "en"});

  set changeDarkMode(value) {
    isDark = value;
    notifyListeners();
  }

  void invertDarkMode() {
    isDark = !isDark;
    notifyListeners();
  }
}
