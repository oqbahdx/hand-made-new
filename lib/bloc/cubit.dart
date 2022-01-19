import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/models/buyer_model.dart';
import 'package:hand_made_new/models/products_model.dart';
import 'package:hand_made_new/models/seller_model.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/models/user_model.dart';
import 'package:hand_made_new/storage/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HandCubit extends Cubit<HandMadeState> {
  HandCubit() : super(HandInitialState());

  static HandCubit get(context) => BlocProvider.of(context);

  int pageIndex = 3;

  changeIndex(int index) {
    pageIndex = index;
    // if(index ==2)
    //   getSellers();
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
        source: src, imageQuality: 80, maxHeight: 800, maxWidth: 800);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(HandUpdateImageSuccessState());
    }
    if (kDebugMode) {
      print(image.path.split('/').last);
    }
    emit(HandUpdateImageSuccessState());
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
        if (kDebugMode) {
          print(value.user.uid);
        }
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
      if (kDebugMode) {
        print(e.toString());
      }
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
      double longitude,
      double latitude}) async {
    Position location = await Geolocator.getCurrentPosition();
    SellerModel sellerModel = SellerModel(
        uid: uid,
        name: name,
        email: email,
        phone: phone,
        isAvailable: isAvailable,
        longitude: location.longitude,
        latitude: location.latitude,
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
        createBuyer(
          uid: value.user.uid,
          email: email,
          name: name,
        );
        showMessageSuccess('Seller Registered Successfully');
        emit(HandBuyerRegisterSuccessState());
      });
    } on FirebaseAuthException catch (error) {
      showMessageError(error.message);
      emit(HandBuyerRegisterErrorState(error.toString()));
    }
  }

  void createBuyer({String uid, String name, String email}) {
    BuyerModel buyerModel =
        BuyerModel(uid: uid, name: name, email: email, profileImage: '');
    FirebaseFirestore.instance
        .collection('buyers')
        .doc(uid)
        .set(buyerModel.toJson());
  }

  void login({String email, String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      emit(HandBuyerLoginLoadingState());
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        showMessageSuccess('you logged in successfully');
        emit(HandBuyerLoginSuccessState(value.user.uid.toString()));
        SharedPref.saveData(key: 'token', value: value.user.uid);
      });
    } on FirebaseAuthException catch (error) {
      showMessageError(error.message);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HandBuyerLoginErrorState(error.toString()));
    }
  }

  List<UserModel> sellers = [];
  List<BuyerModel> buyers = [];

  getSellers() {
    emit(HandGetSellersLoadingState());
    sellers = [];
    FirebaseFirestore.instance
        .collection('/users')
        .where('role',isEqualTo: 'seller')
        .where('isAvailable', isEqualTo: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        sellers.add(UserModel.fromJson(element.data()));
      }
      emit(HandGetSellersSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HandGetSellersErrorState(error.toString()));
    });
  }

  SellerModel sellerModel;
  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(15.5007, 32.5599),
    ),
    Marker(
      markerId: const MarkerId('2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: const LatLng(15.5007, 32.5799),
    ),
    Marker(
      markerId: const MarkerId('3'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      position: const LatLng(15.5307, 32.5599),
    ),
    Marker(
      markerId: const MarkerId('4'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(15.1007, 32.5599),
    ),
    Marker(
      markerId: const MarkerId('5'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: const LatLng(15.5037, 32.5399),
    ),
  };

  void addProductWithImage({String name, String des, String price}) {
    emit(HandUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addProduct(name: name, des: des, image: value, price: price);
        emit(HandUpdateImageSuccessState());
      }).catchError((error) {
        emit(HandUploadImageErrorState(error.toString()));
      });
    });
  }

  addProduct({String name, String des, String image, String price}) {
    emit(HandAddProductLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;
    ProductsModel productsModel = ProductsModel(
        uId: userId, name: name, description: des, image: image, price: price);
    FirebaseFirestore.instance
        .collection('products')
        .add(productsModel.addProduct())
        .then((value) {
      emit(HandAddProductSuccessState());
    }).catchError((error) {
      emit(HandAddProductErrorState(error.toString()));
    });
  }

  void userBuyerRegister({String email, String password, String name}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      emit(HandGetUserLoadingState());
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (kDebugMode) {
          print(value.user.uid);
        }
        createUser(
            email: email,
            role: 'buyer',
            name: name,
            uid: value.user.uid,
            profileImage: '');
        showMessageSuccess('Registered successfully');
        emit(HandUserRegisterSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showMessageError(e.message.toString());
      emit(HandUserRegisterErrorState(e.toString()));
    }
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(HandUserRegisterSuccessState());
    }).catchError((error) {
      emit(HandUserRegisterErrorState(error.toString()));
    });
  }

  void userSellerRegister(
      {String email, String password, String phone, String name}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Position location = await Geolocator.getCurrentPosition();
    try {
      emit(HandGetUserLoadingState());
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (kDebugMode) {
          print(value.user.uid);
        }
        createUser(
          email: email,
          role: 'seller',
          name: name,
          latitude: location.latitude,
          longitude: location.longitude,
          phone: phone,
          isAvailable: true,
          uid: value.user.uid,
          profileImage: '',
        );
        showMessageSuccess('Registered successfully');
        emit(HandUserRegisterSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showMessageError(e.message.toString());
      emit(HandUserRegisterErrorState(e.toString()));
    }
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(HandUserRegisterSuccessState());
    }).catchError((error) {
      emit(HandUserRegisterErrorState(error.toString()));
    });
  }

  UserModel userModel;

  void createUser(
      {String uid,
      String name,
      String email,
      String phone,
      String password,
      double latitude,
      double longitude,
      String role,
      String profileImage,
      bool isAvailable}) {
    userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        profileImage: profileImage,
        isAvailable: true,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        role: role,
        password: password);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toJson());
  }

  getCurrentUser()  {
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser.uid;
    emit(HandGetCurrentUserLoadingState());

    FirebaseFirestore.instance
        .collection('/users')
        .doc(currentUser)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.data());
      }
      userModel = UserModel.fromJson(value.data());
      emit(HandGetCurrentUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HandGetCurrentUserErrorState(error.toString()));
    });
  }

  ProductsModel productsModel;
  List<ProductsModel> products = [];

  getCurrentUserProducts() {
    products = [];
    emit(HandGetCurrentUserProductsLoadingState());
    FirebaseFirestore.instance.collection('/products').get().then((value) {
      for (var element in value.docs) {
        products.add(ProductsModel.fromJson(element.data()));
        emit(HandGetCurrentUserProductsSuccessState());
        if (kDebugMode) {
          print(value.toString());
        }
      }
    }).catchError((err) {
      if (kDebugMode) {
        print(err.toString());
      }
      emit(HandGetCurrentUserProductsErrorState(err.toString()));
    });
  }

  List<ProductsModel> myProducts = [];

  getMyProducts() {
    emit(HandGetMyProductsLoading());
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;

    FirebaseFirestore.instance
        .collection('products')
        .where('uId', isEqualTo: userId)
        .get()
        .then((value) {
      myProducts = [];
      for (var element in value.docs) {
        myProducts.add(ProductsModel.fromJson(element.data()));
      }
      if (kDebugMode) {
        print(myProducts.length);
      }
      emit(HandGetMyProductsSuccess());
    }).catchError((error) {
      emit(HandGetMyProductsError(error.toString()));
    });
  }
}
