import 'package:flutter/material.dart';



Widget defaultTextFormField({
  TextEditingController controller,
  int maxLine,
  TextAlign align,
  TextInputType inputType,
  TextStyle style,
  TextInputAction next, String text, TextInputType type, IconData icn, String Function(dynamic value) function,
}){
  return TextFormField(
    controller: controller,
    maxLength: maxLine,
    textAlign: align,
    keyboardType: inputType,
    style: style,
    textInputAction: next,
   decoration: const InputDecoration(
     counterText: ''
   ),
  );
}

Widget buildTextFormFieldWithBackground({TextEditingController controller ,String txt}){
  return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(

        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white70,
          filled: true,
          focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),

            borderRadius: BorderRadius.circular(15),
          ),
          border:  OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),

            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black54,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ));
}