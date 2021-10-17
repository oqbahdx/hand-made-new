import 'package:flutter/material.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:hand_made_new/widgets/show_dialog.dart';


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
        title: Text('Reset Password',style: normalText,),
        action: Container(),
        elevation: 0.0
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text('Please Enter Your Number',style: bigText,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                controller: phoneController,
                maxLength: 10,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: bigText,
              ),
            ),
            SizedBox(height: 100,),
            containerBuildTap(text: 'NEXT',onTap: (){
              showDialogBuildSimple(context,phoneController.text);
            }),
          ],
        ),
      ),
    );
  }
}
