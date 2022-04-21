import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


PreferredSizeWidget appBarWidget({Widget title,
   double elevation, Widget action,
    }){
  return AppBar(
    title: title,
    centerTitle: true,
    elevation: elevation,
    actions: [action],
    iconTheme:const IconThemeData(
      color: Colors.black87
    ),

    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF3E71),
            Color(0xFFFEC317),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light
    ),
  );
}