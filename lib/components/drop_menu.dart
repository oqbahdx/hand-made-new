import 'package:flutter/material.dart';

String dropdownValueTime = 'اختار اليوم';
String dropdownValueCategory = 'اختار الفئة';
String productCategory;

Widget dropMenuBuild(
    {String dropValue,
    List<String>meals,
    Function(String value) fun}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      DropdownButton<dynamic>(
        value: dropValue,
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: fun,
        items: meals.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      const Text("إختار الفئة"),
    ],
  );
}
