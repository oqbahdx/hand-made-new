import 'package:flutter/material.dart';
import 'package:hand_made_new/widgets/on_boarding_widgets.dart';


Widget floatingNextButton({Function function,IconData icn }){
  return  FloatingActionButton(
    backgroundColor: onBoardingColor,
    onPressed: function,
    child:  Icon(icn),
  );
}