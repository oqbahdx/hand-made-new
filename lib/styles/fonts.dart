import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'colors.dart';


TextStyle containerStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Colors.white
);


TextStyle normalText = TextStyle(
  fontSize: 22,
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

