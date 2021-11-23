import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/text_forms.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key key}) : super(key: key);
  static String id = "VerifyOtp";

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  FocusNode node1;
  FocusNode node2;
  FocusNode node3;
  FocusNode node4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          elevation: 0.0,
          action: Container(),
          title: Text(
            'Verification',
            style: normalText,
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: defaultTextFormField(
                    align: TextAlign.center,
                    inputType: TextInputType.number,
                    maxLine: 1,
                    style: bigText,
                    controller: controller1,
                    next: TextInputAction.next),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: defaultTextFormField(
                    align: TextAlign.center,
                    inputType: TextInputType.number,
                    maxLine: 1,
                    style: bigText,
                    controller: controller2,
                    next: TextInputAction.next),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: defaultTextFormField(
                    align: TextAlign.center,
                    inputType: TextInputType.number,
                    maxLine: 1,
                    style: bigText,
                    controller: controller3,
                    next: TextInputAction.next),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: defaultTextFormField(
                    align: TextAlign.center,
                    inputType: TextInputType.number,
                    maxLine: 1,
                    style: bigText,
                    controller: controller4,
                    next: TextInputAction.done),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
