import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);
  static String id = "ContactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
      ),
    );
  }
}
