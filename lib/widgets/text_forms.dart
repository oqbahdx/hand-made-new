import 'package:flutter/material.dart';



Widget defaultTextFormField({
  TextEditingController controller,
  int maxLine,
  TextAlign align,
  TextInputType inputType,
  TextStyle style,
  TextInputAction next,
}){
  return TextFormField(
    controller: controller,
    maxLength: maxLine,
    textAlign: align,
    keyboardType: inputType,
    style: style,
    textInputAction: next,
   decoration: InputDecoration(
     counterText: ''
   ),
  );
}