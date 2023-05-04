// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TestContainer extends StatelessWidget {
  String task;
  bool isFinished;
  Function(bool?)? onTap;
  TestContainer({
    Key? key,
    required this.task,
    required this.isFinished,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      trailing: Checkbox(
        onChanged: onTap,
        value: isFinished,
      ),
    );
  }
}
