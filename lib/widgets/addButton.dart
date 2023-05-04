import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/Apptheme_provider.dart';

Container AddButton(BuildContext context) {
  final provider = Provider.of<AppTheme>(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 50),
    height: 50,
    width: 90,
    decoration: BoxDecoration(
      color:
          provider.currentTheme == provider.dark ? Colors.grey : Colors.orange,
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
