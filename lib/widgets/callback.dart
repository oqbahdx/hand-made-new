import 'package:flutter/material.dart';



class CallBackIndicator extends StatelessWidget {
  const CallBackIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white,),
    );
  }
}
