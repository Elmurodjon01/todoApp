import 'package:flutter/material.dart';

Container CustomBackground({required Widget child, required String imgAdress}) {
  return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              imgAdress,
            ),
            fit: BoxFit.cover),
      ),
      child: child);
}
