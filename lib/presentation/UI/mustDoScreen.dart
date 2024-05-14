import 'package:flutter/material.dart';

class MustDoScreen extends StatelessWidget {
  const MustDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
    );
  }
}
