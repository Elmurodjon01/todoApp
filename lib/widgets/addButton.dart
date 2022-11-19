import 'package:flutter/material.dart';

Container AddButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 50),
    height: 50,
    width: 90,
    decoration: BoxDecoration(
      color: Colors.orange,
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
