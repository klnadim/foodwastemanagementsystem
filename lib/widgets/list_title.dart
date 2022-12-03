import 'package:flutter/material.dart';

ListTile listtile(String text, IconData iconData) =>
      ListTile(title: Text("$text"), leading: Icon(iconData));