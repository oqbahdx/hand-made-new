import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '/state_management/cubit.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();

  runApp(

      const MyApp(
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>HandCubit()),

        ],

        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Amiri',
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RegisterMainPage.id,
          routes: {
            OnBoarding.id:(context)=>OnBoarding(),
            StartPage.id:(context)=>const StartPage(),
            MapPage.id:(context)=>const MapPage(),
            AddProduct.id:(context)=>const AddProduct(),
            LoginPage.id:(context)=>const LoginPage(),
            RegisterMainPage.id:(context)=>const RegisterMainPage(),
            SellerRegisterPage.id:(context)=>SellerRegisterPage(),
            BuyerRegisterPage.id:(context)=>BuyerRegisterPage(),
            OTPPage.id:(context)=>const OTPPage(),
            VerifyOtp.id:(context)=>const VerifyOtp(),
          },

    ),
      );
  }
}
