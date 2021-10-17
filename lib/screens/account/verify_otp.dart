import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key key}) : super(key: key);
  static String id = "VerifyOtp";
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        elevation: 0.0,
        action: Container(),
        title: Text('Verification',style: normalText,)
      ),
    );
  }
}
