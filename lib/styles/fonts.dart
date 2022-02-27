import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'colors.dart';


TextStyle containerStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22,
  color: Colors.white
);

TextStyle bigText = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle normalText = const TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
);
TextStyle smallText = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,

);
TextStyle appBarStyle = const TextStyle(
  fontSize: 21,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

Widget gradientText({String text,Function onTap}){
 return GestureDetector(
   onTap: onTap,
   child: GradientText(
      text,
      style: normalText,
      colors: gradientColor,
    ),
 );
}

