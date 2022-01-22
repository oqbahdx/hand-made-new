import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/account/sellers_details.dart';
import 'package:hand_made_new/screens/drawer/contact_us.dart';
import 'package:hand_made_new/screens/drawer/favorite.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/time_line.dart';
import 'package:hand_made_new/screens/products/my_products.dart';
import 'package:hand_made_new/screens/products/products%20test.dart';
import 'package:hand_made_new/screens/products/products_detalis.dart';

import 'package:hand_made_new/storage/shared.dart';

import '/screens/account/login.dart';
import '/screens/account/buyer_register.dart';
import '/screens/account/main_register.dart';
import '/screens/account/otp.dart';
import '/screens/account/seller_register.dart';
import '/screens/account/verify_otp.dart';
import '/screens/home/map.dart';
import '/screens/home/start.dart';
import '/screens/intro/onBoarding.dart';
import '/screens/products/add_product.dart';
import '/bloc/cubit.dart';
import 'bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget startPage;
  var onBoarding = await SharedPref.getData(key: 'onBoarding');
  uId = await SharedPref.getData(key: 'uId');
  if (onBoarding != null) {
    if (token != null) {
      startPage = const StartPage();
    } else {
      startPage = const LoginPage();
    }
  } else {
    startPage = const OnBoarding();
  }
  BlocOverrides.runZoned(
    () => runApp(DevicePreview(
      enabled: false,
      builder: (context) => MyApp(
        startPage: startPage,
      ),
    )),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final HandCubit _handCubit = HandCubit();

  MyApp({Key key, this.startPage}) : super(key: key);

  final Widget startPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandCubit(),
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: 'Amiri',
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: ProductDetails.id,
        home: startPage,
        routes: {
          OnBoarding.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const OnBoarding()),
          StartPage.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const StartPage()),
          MapPage.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const MapPage()),
          AddProduct.id: (context) => const AddProduct(),
          LoginPage.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const LoginPage()),
          RegisterMainPage.id: (context) => BlocProvider.value(
              value: _handCubit, child: const RegisterMainPage()),
          SellerRegisterPage.id: (context) => BlocProvider.value(
              value: _handCubit, child: const SellerRegisterPage()),
          BuyerRegisterPage.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const BuyerRegisterPage()),
          OTPPage.id: (context) => BlocProvider.value(
              value: _handCubit,
              child: BlocProvider.value(
                  value: _handCubit, child: const OTPPage())),
          VerifyOtp.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const VerifyOtp()),
          SellerDetails.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const SellerDetails()),
          Profile.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const Profile()),
          MyProducts.id: (context) => const MyProducts(),
          ProductText.id: (context) => const ProductText(),
          ContactUs.id:(context)=>const ContactUs(),
          FavoritePage.id:(context)=> const FavoritePage(),
          TimeLine.id:(context)=>const TimeLine(),
          ProductDetails.id:(context)=>const ProductDetails()
        },
      ),
    );
  }
}
