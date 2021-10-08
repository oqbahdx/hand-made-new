import 'package:flutter/material.dart';


PreferredSizeWidget appBarWidget({Widget? title,
   double? elevation, Widget? action,
   Color? color, Widget? flexible}){
  return AppBar(
    title: title,
    centerTitle: true,
    elevation: elevation,
    actions: [action!],
    backgroundColor: color,
    flexibleSpace: flexible,
  );
}