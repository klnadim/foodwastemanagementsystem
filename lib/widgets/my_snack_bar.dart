import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      {required BuildContext context,
      required String message,
      required Color backgroundColor,
      required Color textColor,
      required Duration duration,
      String? snackbarFunctionLabel,
      VoidCallback? snackbarFunction}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: SnackBarAction(
          label: snackbarFunctionLabel!,
          onPressed: snackbarFunction!,
        ),
      ),
    );
  }
}
