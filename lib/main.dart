import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/account/sellers_details.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/products/my_products.dart';
import 'package:hand_made_new/screens/products/products%20test.dart';
import 'package:hand_made_new/screens/products/seller_products.dart';

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
    if (token != null)
      startPage = StartPage();
    else
      startPage = LoginPage();
  } else {
    startPage = OnBoarding();
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
  MyApp({this.startPage});

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
        // initialRoute: ProductText.id,
        home: startPage,
        routes: {
          OnBoarding.id: (context) =>
              BlocProvider.value(value: _handCubit, child: OnBoarding()),
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
              value: _handCubit, child: SellerRegisterPage()),
          BuyerRegisterPage.id: (context) =>
              BlocProvider.value(value: _handCubit, child: BuyerRegisterPage()),
          OTPPage.id: (context) => BlocProvider.value(
              value: _handCubit,
              child: BlocProvider.value(
                  value: _handCubit, child: const OTPPage())),
          VerifyOtp.id: (context) =>
              BlocProvider.value(value: _handCubit, child: const VerifyOtp()),
          SellerDetails.id: (context) =>
              BlocProvider.value(value: _handCubit, child: SellerDetails()),
          Profile.id: (context) =>
              BlocProvider.value(value: _handCubit, child: Profile()),
          MyProducts.id:(context)=> MyProducts(),
          ProductText.id:(context)=>ProductText()
        },
      ),
    );
  }
}
