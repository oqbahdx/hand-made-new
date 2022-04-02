import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';


List<Color> gradientColor = [
  const Color(0xFFFF3E71),
  const Color(0xFFFEC317),
];

class ProductItemColor extends BlocBase {
  ProductItemColor();
var colorController = BehaviorSubject<Color>.seeded(Colors.white);
Stream<Color> get colorStream => colorController.stream;
Sink<Color> get colorSink => colorController.sink;

setColor(Color color){
  colorSink.add(color);
}
@override
  void dispose(){
  colorController.close();
  super.dispose();
}

}