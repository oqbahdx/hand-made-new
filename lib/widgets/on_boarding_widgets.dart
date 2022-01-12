import 'package:flutter/material.dart';

Widget onBoardingWidget(String imageName, String title, String body) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
          child: Image(
            fit: BoxFit.contain,
            height: 350,
        width: 350,
        image: AssetImage(imageName),
      )),
      const SizedBox(
        height: 150,
      ),
      Text(title,style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),),
      const SizedBox(
        height: 150,
      ),
      Text(body,style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),),
    ],
  );
}

const Color onBoardingColor = Color(0xFFC70039);