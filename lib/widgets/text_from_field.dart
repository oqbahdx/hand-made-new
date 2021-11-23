import 'package:flutter/material.dart';



Widget defaultTextFormField(
    {String text,
      IconData icn,
      TextEditingController controller,
      TextInputType type,
      Function(String value) function,
      Function(String value) saveFunction,
      Widget showPass,
      bool sec = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(

      style: const TextStyle(
        fontWeight: FontWeight.bold
      ),
      keyboardType: type,
      controller: controller,
      obscureText: sec,
      validator: function,
      onSaved: saveFunction,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: text,
          prefixIcon: Icon(icn),
          suffixIcon: showPass
      ),
    ),
  );
}