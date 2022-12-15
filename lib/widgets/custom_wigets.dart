import 'package:flutter/material.dart';

Widget myFormField(
    String? iniValue,
    TextEditingController controller,
    String lText,
    TextInputType? inputType,
    String? Function(String?)? valiDator) {
  return TextFormField(
    initialValue: iniValue ?? "",
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(
        labelText: lText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: OutlineInputBorder()),
    validator: valiDator,
  );
}

TextFormField textFormField(TextEditingController controller, String lText,
    TextInputType? inputType, String? Function(String?)? valiDator) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(
        labelText: lText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: OutlineInputBorder()),
    validator: valiDator,
  );
}
