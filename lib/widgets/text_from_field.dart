import 'package:flutter/material.dart';



Widget defaultTextFormField(
    {String text,
      IconData icn,
      TextEditingController controller,
      TextInputType type,
      function(String value),
      Widget showPass,
      bool sec = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: sec,
      validator: function,
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