import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/models/buyer_model.dart';
import 'package:hand_made_new/models/seller_model.dart';
import 'package:hand_made_new/state_management/states.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

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

  void sellerRegister(
      {String name,
      String email,
      String password,
      String phone,
      String isAvailable}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      emit(HandSellerRegisterLoadingState());
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user.uid);
        createSeller(
          name: name,
          email: email,
          phone: phone,
          uid: value.user.uid,
          isAvailable: isAvailable,
        );
        showMessageSuccess('Seller Registered successfully');
        emit(HandSellerRegisterSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showMessageError(e.message.toString());
      emit(HandSellerRegisterErrorState(e.toString()));
    }
  }

  void createSeller(
      {String uid,
      @required String name,
      @required String email,
      @required String phone,
      String isAvailable,
      String location}) async {
    Position location = await Geolocator.getCurrentPosition();
    SellerModel sellerModel = SellerModel(
        uid: uid,
        name: name,
        email: email,
        phone: phone,
        isAvailable: isAvailable,
        location: '${location.longitude}:${location.latitude}',
        profileImage: '');
    FirebaseFirestore.instance
        .collection('sellers')
        .doc(uid)
        .set(sellerModel.toJson());
  }

  void registerBuyer({String name, String email, String password}) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    emit(HandBuyerRegisterLoadingState());
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        createBuyer(uid: value.user.uid, email: email, name: name,);
        showMessageSuccess('Seller Registered Successfully');
        emit(HandBuyerRegisterSuccessState());
      });
    } on FirebaseAuthException catch (error) {
      showMessageError(error.message);
      emit(HandBuyerRegisterErrorState(error.toString()));
    }
  }

  void createBuyer({String uid, String name, String email}) {
    BuyerModel buyerModel = BuyerModel(
      uid: uid,
      name: name,
      email: email,
      profileImage: ''
    );
    FirebaseFirestore.instance
        .collection('buyers')
        .doc(uid)
        .set(buyerModel.toJson());
  }
}
