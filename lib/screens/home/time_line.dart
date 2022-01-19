import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';


class TimeLine extends StatefulWidget {
  const TimeLine({Key key}) : super(key: key);



  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor
          )
        ),
        child: const Center(child: Text('time line',style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold
        ),),),
      ),
    );
  }
}