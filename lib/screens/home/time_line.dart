import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key key}) : super(key: key);
  static String id = "TimeLine";
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
          child: const Center(
            child: Text(
              'time line',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        floatingActionButton: Card(
          elevation: 20.0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black54),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
