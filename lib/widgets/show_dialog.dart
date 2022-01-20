import 'package:flutter/material.dart';
import 'package:hand_made_new/screens/account/verify_otp.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:image_picker/image_picker.dart';

showDialogBuild(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.black54,
        title: const Text('Select Image From :', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(colors: [
                    Color(0xFFFF3E71),
                    Color(0xFFFEC317),
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(
                        fontFamily: 'messiri', color: Colors.white),
                  ),
                  onTap: () {
                    HandCubit.get(context).getImage(ImageSource.gallery);

                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(colors: [
                    Color(0xFFFF3E71),
                    Color(0xFFFEC317),
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  title: const Text('Camera',
                      style: TextStyle(
                          fontFamily: 'messiri', color: Colors.white)),
                  onTap: () {
                    HandCubit.get(context).getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ));
}

showDialogOTPBuildSimple(BuildContext context, String numberController) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Center(child: Text('Warring :  is correct ?', style: normalText)),
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      numberController,
                      style: bigText,
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.clear,color: Colors.red,)),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              moveToPage(context, VerifyOtp.id);
                            },
                            child: Text(
                              'OK',
                              style: smallText,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
}
