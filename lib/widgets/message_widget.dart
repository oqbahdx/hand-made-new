import 'package:flutter/material.dart';
import 'package:hand_made_new/models/message_model.dart';

Widget sendMessage(MessageModel model) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        model.text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      height: 50,
      width: 200,
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(15))),
    ),
  );
}

Widget receiveMessage(MessageModel model) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      alignment: Alignment.center,
      child:  Text(
        model.text,
        style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 22),
      ),
      height: 50,
      width: 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(15),
          )),
    ),
  );
}
