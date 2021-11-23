import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HandCubit extends Cubit<HandMadeState> {
  HandCubit() : super(HandInitialState());

  static HandCubit get(context) => BlocProvider.of(context);

  int pageIndex = 1;

  changeIndex(int index) {
    pageIndex = index;
    emit(HandChangeButtonNavState());
  }

  String dropdownValueTime = 'اختار اليوم';
  String dropdownValueCategory = 'اختار الفئة';
  String productCategory;

  changeDropItem(String newValue, String value) {
    dropdownValueCategory = newValue;
    productCategory = value;
    emit(HandChangeDropMenuItemState());
  }

  final picker = ImagePicker();
  File image;

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(
        source: src, imageQuality: 80, maxHeight: 300, maxWidth: 300);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(HandUpdateImageSuccessState());
    }
    print(image.path.split('/').last);
  }

  bool isShow = true;
  IconData icon = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isShow = !isShow;
    icon = isShow ? Icons.visibility_off_outlined : Icons.visibility;
    emit(HandChangePasswordVisibility());
  }

  int index = 0;

  pageChanged(int value) {
    index = value;
    emit(HandChangeTitleMainRegisterSuccessState());
  }

  GlobalKey<FormState> formKey = GlobalKey();

  void sellerRegister({String email, String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1 60505 556 789',
        verificationCompleted: (PhoneAuthCredential credential) async{
          emit(HandSellerRegisterLoadingState());
          await auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            print(value.user.uid);
            showMessageSuccess(value.user.toString());
            emit(HandSellerRegisterSuccessState());
          });
        },
         verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int resendToken) async {
          // emit(HandSellerRegisterLoadingState());
          String smsCode = '1992';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
        },

        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showMessageError(e.message.toString());
      emit(HandSellerRegisterErrorState(e.toString()));

      ;
    }
  }
}
