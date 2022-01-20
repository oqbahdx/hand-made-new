import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);
  static String id = "ContactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: const Text('Contact us',style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          elevation: 0.0,
          action: Container()
        ),
        body: Container(
          child: const Center(
            child: Text('contact us',style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold
            ),),
          ),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
        ),
      ),
    );
  }
}
