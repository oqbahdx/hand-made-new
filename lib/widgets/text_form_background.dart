import 'package:flutter/material.dart';

Widget buildTextFormFieldWithBackground(
    {TextEditingController controller,
    String txt,
    Function(String) validator,
      TextInputType inputType
   }) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: Colors.white,
        validator: validator,
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: inputType,

        style:  const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          labelText: txt,
          labelStyle: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
          fillColor: Colors.white70,
          errorStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ));
}
