import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';
import 'package:hand_made_new/widgets/text_forms.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key key}) : super(key: key);
  static String id = "OTPPage";

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: Text(
            'Reset Password',
            style: normalText,
          ),
          action: Container(),
          elevation: 0.0),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Please Enter Your Number',
              style: bigText,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: defaultTextFormField(
                    controller: phoneController,
                    style: bigText,
                    align: TextAlign.center,
                    maxLine: 10,
                    inputType: TextInputType.number)),
            const SizedBox(
              height: 100,
            ),
            containerBuildTap(
                text: 'NEXT',
                onTap: () {
                  showDialogOTPBuildSimple(context, phoneController.text);
                }),
          ],
        ),
      ),
    );
  }
}
