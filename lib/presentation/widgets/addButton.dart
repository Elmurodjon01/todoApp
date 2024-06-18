import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/presentation/Theme/Apptheme_provider.dart';

Container AddButton(BuildContext context) {
  final provider = Provider.of<ThemeProvider>(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 50),
    height: 50,
    width: 90,
    decoration: BoxDecoration(
      color: Colors.orange,
      //TODO: come here
      // remote.themeMode == remote.isDarkMode ? Colors.grey : Colors.orange,
      borderRadius: BorderRadius.circular(20),
    ),
    child: IconButton(
      onPressed: () {
        Navigator.pushNamed(context, '/addScreen');
      },
      icon: const Icon(Icons.edit),
    ),
  );
}
