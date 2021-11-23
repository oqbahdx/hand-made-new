import 'package:flutter/material.dart';
import '/styles/colors.dart';
import '/styles/fonts.dart';

Widget containerBuildTap(
    {String text, Function onTap, double h = 50, double w = 600}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Text(
            text,
            style: containerStyle,
          ),
        ),
        height: h,
        width: w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            )),
      ),
    ),
  );
}

Widget defaultButtonTap(String text, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: gradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Center(
          child: Text(
            text,
            style: containerStyle,
          ),
        ),
      ),
    ),
  );
}
