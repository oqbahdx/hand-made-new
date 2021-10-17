import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'colors.dart';


TextStyle containerStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.white
);

TextStyle bigText = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle normalText = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
);
TextStyle smallText = TextStyle(
  fontSize: 16,
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

