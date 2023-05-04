import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData light =
      ThemeData(appBarTheme: const AppBarTheme(color: Colors.orange))
          .copyWith();

  ThemeData dark = ThemeData.dark().copyWith();

  ThemeData get currentTheme => _isDarkMode ? dark : light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
