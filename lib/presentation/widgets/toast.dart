import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  void showToast(String message, BuildContext context) {
    toastification.show(
      context: context,
      title: Text(
        message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      autoCloseDuration: const Duration(seconds: 5),
      pauseOnHover: true,
    );
  }
}
