import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Welcome'), // To display the title it is optional
      content:
          Text('GeeksforGeeks'), // Message which will be pop up on the screen
      // Action widget which will provide the user to acknowledge the choice
      actions: [
        TextButton(
          // FlatButton widget is used to make a text to work like a button

          onPressed:
              () {}, // function used to perform after pressing the button
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('ACCEPT'),
        ),
      ],
    );
  }
}
