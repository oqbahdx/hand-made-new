import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget startBottomNav({List<GButton> gButton,int index,Function(int) function}) {
  return GNav(
    rippleColor: Colors.grey,
    hoverColor: Color(0xFFF15B5D),
    gap: 8,
    activeColor: Colors.white,
    iconSize: 24,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    duration: Duration(milliseconds: 400),
    tabBackgroundColor: Color(0xFFF15B5D),
    tabs: gButton,
    selectedIndex: index,
    onTabChange: function
  );
}

GButton gButtonNav({
  IconData icon,
  String text,
}) {
  return GButton(
    icon: icon,
    text: text,
    textStyle: TextStyle(
        fontSize: 16,
        fontFamily: 'Amiri',
        color: Colors.white,
        fontWeight: FontWeight.bold),
    backgroundGradient: LinearGradient(colors: [
      Color(0xFFFF3E71),
      Color(0xFFFEC317),
    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
  );
}
