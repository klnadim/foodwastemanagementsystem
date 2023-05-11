import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  String title;
  String contains;
  VoidCallback button1;

  CustomDialogBox(
      {Key? key,
      required this.title,
      required this.contains,
      required this.button1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(contains),
      actions: [
        ElevatedButton(onPressed: button1, child: const Text("Confirm")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"))
      ],
    );
  }
}

Future<void> showMyDialog(BuildContext context, String title, String contains,
    VoidCallback button1) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(contains),
        actions: <Widget>[
          TextButton(onPressed: button1, child: const Text("Confirm")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"))
        ],
      );
    },
  );
}
