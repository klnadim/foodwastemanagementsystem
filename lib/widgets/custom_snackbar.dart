import 'package:flutter/material.dart';

SnackBar snackBar(
    String txt, String labelText, VoidCallback labelActionButton) {
  return SnackBar(
    content: Text(
      txt,
      style: TextStyle(color: Colors.redAccent),
    ),
    backgroundColor: Colors.blueGrey[50],
    action: SnackBarAction(
      label: labelText,
      onPressed: labelActionButton,
    ),
  );
}
