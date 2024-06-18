import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePreference {
  // to set the mode
  Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

// to get the mode
  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme').toString();
  }
}

enum ThemeType { light, dark }

//Theme remote
class ThemeProvider extends ChangeNotifier {
  SavePreference pre = SavePreference();
  ThemeData currentTheme = lightTheme;
  ThemeType themeType = ThemeType.light;

  ThemeProvider() {
    setInitialTheme();
  }

  setInitialTheme() {
    ThemeData theme = lightTheme;
    pre.getTheme().then((value) {
      if (value != "null") {
        theme = (value == "dark") ? darkTheme : lightTheme;
      }
      currentTheme = theme;
      themeType = (theme == lightTheme) ? ThemeType.light : ThemeType.dark;
      notifyListeners();
    });
  }

  changeCurrentTheme() {
    if (currentTheme == darkTheme) {
      themeType = ThemeType.light;
      currentTheme = lightTheme;
    } else {
      themeType = ThemeType.dark;
      currentTheme = darkTheme;
    }
    pre.setTheme(themeType.name);
    notifyListeners();
  }
}

//theme data for each theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardTheme: const CardTheme(surfaceTintColor: Color(0xff101820)),
  fontFamily: "Lato",
  iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
  appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextTheme(
        headlineMedium: TextStyle(
          color: Color.fromARGB(255, 253, 252, 252),
        ),
        // displayLarge: TextStyle(color: Colors.white),
        // displaySmall: TextStyle(color: Colors.white),
        // displayMedium: TextStyle(color: Colors.white),
        // bodyLarge: TextStyle(color: Colors.white),
        // bodyMedium: TextStyle(color: Colors.white),
        // bodySmall: TextStyle(color: Colors.white),
      ).headlineMedium),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xff29b6f6),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardTheme(surfaceTintColor: Colors.white),
  fontFamily: "Lato",
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.orange,
      surfaceTintColor: Colors.orange,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle:
          const TextTheme(headlineMedium: TextStyle(color: Colors.black))
              .headlineMedium),
);
