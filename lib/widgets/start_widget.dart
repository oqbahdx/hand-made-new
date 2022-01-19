import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget startBottomNav({List<GButton> gButton,int index,Function(int) function}) {
  return GNav(
    rippleColor: Colors.grey,
    hoverColor: Colors.white,
    gap: 8,
    activeColor: Colors.white,
    iconSize: 24,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    duration: const Duration(milliseconds: 100),
    tabBackgroundColor: const Color(0xFFF15B5D),
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
    textStyle: const TextStyle(
        fontSize: 15,
        fontFamily: 'Amiri',
        color: Colors.white,
        fontWeight: FontWeight.bold),
    backgroundGradient: const LinearGradient(colors: [
      Colors.black54,
        Colors.black54,
    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
  );
}
