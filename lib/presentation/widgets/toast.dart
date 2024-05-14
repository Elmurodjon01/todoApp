import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  void showToast(String message, BuildContext context) {
    toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
