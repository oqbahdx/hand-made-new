import 'package:flutter/material.dart';

Widget onBoardingWidget(String imageName, String title, String body) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
          child: Image(
            fit: BoxFit.fill,
            height: 550,
        width: 450,
        image: AssetImage(imageName),
      )),
      const SizedBox(
        height: 150,
      ),
      Text(title,style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold
      ),),
      const SizedBox(
        height: 150,
      ),
      Text(body,style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold
      ),),
    ],
  );
}

const Color onBoardingColor = Color(0xFFC70039);