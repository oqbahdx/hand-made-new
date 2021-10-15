import 'package:flutter/material.dart';


class TimeLine extends StatefulWidget {
  const TimeLine({Key key}) : super(key: key);



  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('time line'),),
    );
  }
}