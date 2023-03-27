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
    // return AlertDialog(
    //   title: Text('Welcome'), // To display the title it is optional
    //   content:
    //       Text('GeeksforGeeks'), // Message which will be pop up on the screen
    //   // Action widget which will provide the user to acknowledge the choice
    //   actions: [
    //     TextButton(
    //       // FlatButton widget is used to make a text to work like a button

    //       onPressed:
    //           () {}, // function used to perform after pressing the button
    //       child: Text('CANCEL'),
    //     ),
    //     TextButton(
    //       onPressed: () {},
    //       child: Text('ACCEPT'),
    //     ),
    //   ],
    // );
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
