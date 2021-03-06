import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/models/buyer_model.dart';
import 'package:hand_made_new/models/message_model.dart';
import 'package:hand_made_new/models/products_model.dart';
import 'package:hand_made_new/models/seller_model.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/models/user_model.dart';
import 'package:hand_made_new/storage/shared.dart';
import 'package:hand_made_new/widgets/navigators.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/favorite_model.dart';

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
    BuyerModel buyerModel = BuyerModel(
        uid: uid,
        name: name,
        email: email,
        profileImage:
            'https://firebasestorage.googleapis.com/v0/b/hand-made-adbb4.appspot.com/o/applogo.png?alt=media&token=9d581d89-bf1c-40e5-af93-e65bbaf75e4d');
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
        .collection('users')
        .where('isAvailable', isEqualTo: true)
        .where('role', isEqualTo: 'seller')
        .limit(10)
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

  void updateProfile({
    @required String image,
    @required String name,
    @required String email,
    @required bool isAvailable,
    @required GeoPoint location,
    @required String password,
    @required String phone,
    @required String role,
    @required String uid,
  }) {
    emit(HandUpdateCurrentUserProfileLoading());
    UserModel currentUserModel = UserModel(
      profileImage: image,
      name: name,
      email: email,
      isAvailable: isAvailable,
      location: location,
      password: password,
      phone: phone,
      role: role,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(currentUserModel.toJson())
        .then((value) {
      emit(HandUpdateCurrentUserProfileSuccess());
    }).catchError((err) {
      print(err.toString());
      emit(HandUpdateCurrentUserProfileError(err.toString()));
    });
  }

  void updateProfileWithImage({
    String name,
    String email,
    bool isAvailable,
    GeoPoint location,
    String password,
    String phone,
    String role,
    String uid,
  }) {
    emit(HandUpdateProfileWithImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersImage/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      emit(HandUpdateProfileWithImageSuccess());
      value.ref.getDownloadURL().then((value) {
        updateUser(
            image: value,
            name: name,
            email: email,
            isAvailable: isAvailable,
            location: location,
            password: password,
            phone: phone,
            role: role,
            uid: uid);
      }).catchError((err) {
        print(err.toString());
        emit(HandUpdateProfileWithImageError(err.toString()));
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
        .add(productsModel.toJson())
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
            profileImage:
                'https://firebasestorage.googleapis.com/v0/b/hand-made-adbb4.appspot.com/o/applogo.png?alt=media&token=9d581d89-bf1c-40e5-af93-e65bbaf75e4d');
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
          location: GeoPoint(location.latitude, location.longitude),
          phone: phone,
          isAvailable: true,
          uid: value.user.uid,
          profileImage:
              'https://firebasestorage.googleapis.com/v0/b/hand-made-adbb4.appspot.com/o/applogo.png?alt=media&token=9d581d89-bf1c-40e5-af93-e65bbaf75e4d',
        );
        showMessageSuccess('Registered successfully');
        emit(HandUserRegisterSuccessState());
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showMessageError(e.message.toString() + '\u{1F605}');
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
      var location,
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
        location: location,
        role: role,
        password: password);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toJson());
  }

  getCurrentUser() {
    emit(HandGetCurrentUserLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser.uid;
    emit(HandGetCurrentUserLoadingState());

    FirebaseFirestore.instance
        .collection('/users')
        .doc(currentUser)
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (kDebugMode) {
        print(value.data());
      }
      userModel = UserModel.fromJson(value.data());
      emit(HandGetCurrentUserSuccessState());
      print(value.toString());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HandGetCurrentUserErrorState(error.toString()));
    });
  }

  ProductsModel productsModel;
  List<ProductsModel> products = [];

  getCurrentUserProducts(String uid) {
    products = [];
    emit(HandGetCurrentUserProductsLoadingState());
    FirebaseFirestore.instance
        .collection('/products')
        .where('uId', isEqualTo: uid)
        .get()
        .then((value) {
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
        .snapshots();
  }

  updateUser({
    @required String image,
    @required String name,
    @required String email,
    @required bool isAvailable,
    @required GeoPoint location,
    @required String password,
    @required String phone,
    @required String role,
    @required String uid,
  }) {
    emit(HandUpdateCurrentUserProfileLoading());
    UserModel currentUserModel = UserModel(
      profileImage: image,
      name: name,
      email: email,
      isAvailable: isAvailable,
      location: location,
      password: password,
      phone: phone,
      role: role,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(currentUserModel.toJson())
        .then((value) {
      emit(HandUpdateCurrentUserProfileLoading());
    }).catchError((err) {
      if (kDebugMode) {
        print(err.toString());
      }
      emit(HandUpdateCurrentUserProfileError(err.toString()));
    });
  }

  bool isOnline;

  changeIsOnline(bool value) {
    isOnline = value;
    emit(HandChangeIsOnlineState());
  }

  List<MessageModel> messages = [];

  sendMessage({String receiverId, String text, String date}) {
    MessageModel messageModel = MessageModel(
        text: text,
        senderId: userModel.uid,
        date: date,
        receiverId: receiverId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(HandSendMessageSuccess());
    }).catchError((err) {
      emit(HandSendMessageError(err.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(HandSendMessageSuccess());
    }).catchError((err) {
      emit(HandSendMessageError(err.toString()));
    });
  }

  getMessages({String receiverId}) {
    emit(HandGetMessagesLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.formJson(element.data()));
      }
    });
    emit(HandGetMessagesSuccess());
  }

  List<FavoriteModel> favorite = [];

  addToFavorite(
      {String name,
      String image,
      String userId,
      String des,
      String price,
      String productId}) {
    emit(HandAddToFavoriteLoading());
    FavoriteModel favoriteModel = FavoriteModel(
      isFavorite: true,
      productId: productId,
      productImage: image,
      productName: name,
      userId: userId,
      productDes: des,
      productPrice: price,
    );
    FirebaseFirestore.instance
        .collection('favorites')
        .add(favoriteModel.toJson())
        .then((value) {
      print(value.toString());
      emit(HandAddToFavoriteSuccess());
    }).catchError((err) {
      print(err.toString());
      emit(HandAddToFavoriteError(err));
    });
  }

  deleteFavoriteItem({String productId}) {
    FirebaseFirestore.instance
        .collection('favorites')
        .doc(productId)
        .delete()
        .then((value) {
      emit(HandDeleteFavoriteItemSuccess());
    }).catchError((err) {
      emit(HandDeleteFavoriteItemError(err.toString()));
    });
  }

  FavoriteModel favoriteModel;
  List<FavoriteModel> favoritesList = [];

  getAllFavorites() {
    emit(HandGetAllFavoritesLoading());
    FirebaseFirestore.instance
        .collection('favorites')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      favoritesList = [];

      for (var element in value.docs) {
        favoritesList.add(FavoriteModel.fromJson(element.data()));
        print(favoritesList[0].productName);
      }
      emit(HandGetAllFavoritesSuccess());
    }).catchError((err) {
      print(err.toString());
      emit(HandGetAllFavoritesError(err.toString()));
    });
  }

  deleteProduct({String id}) {
    emit(HandDeleteProductLoading());
    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .delete()
        .then((value) => () {
              emit(HandDeleteProductSuccess());
            })
        .catchError((err) {
      print(err.toString());
      emit(HandDeleteProductError(err.toString()));
    });
  }

  updateProduct(
      {String uid,
      String id,
      String name,
      String image,
      String desc,
      String price}) {
    ProductsModel model = ProductsModel(
      name: name,
      description: desc,
      image: image,
      price: price,
      uId: uid,
    );
    emit(HandUpdateProductLoading());
    FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .update(model.toJson())
        .then((value) {
      emit(HandUpdateProductSuccess());
    }).catchError((err) {
      emit(HandUpdateProductError(err.toString()));
      print(err.toString());
    });
  }

  void updateProductWithImage(
      {String name, String des, String price, String id, String uid}) {
    emit(HandUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProduct(
            image: value,
            desc: des,
            price: price,
            name: name,
            id: id,
            uid: uid);
        emit(HandUpdateImageSuccessState());
      }).catchError((error) {
        emit(HandUploadImageErrorState(error.toString()));
      });
    });
  }
  Position location;
  getCurrentLocation() async {
    location = await Geolocator.getCurrentPosition();
  }
}
