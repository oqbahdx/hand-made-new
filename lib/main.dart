import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/account/login.dart';
import 'package:hand_made_new/screens/account/main_register.dart';
import 'package:hand_made_new/screens/account/otp.dart';
import 'package:hand_made_new/screens/account/verify_otp.dart';
import 'package:hand_made_new/screens/home/map.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/screens/intro/onBoarding.dart';
import 'package:hand_made_new/screens/products/add_product.dart';

import 'package:hand_made_new/state_management/cubit.dart';

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
          initialRoute: LoginPage.id,
          routes: {
            OnBoarding.id:(context)=>OnBoarding(),
            StartPage.id:(context)=>const StartPage(),
            MapPage.id:(context)=>const MapPage(),
            AddProduct.id:(context)=>const AddProduct(),
            LoginPage.id:(context)=>const LoginPage(),
            RegisterMainPage.id:(context)=>const RegisterMainPage(),
            OTPPage.id:(context)=>const OTPPage(),
            VerifyOtp.id:(context)=>const VerifyOtp(),
          },

    ),
      );
  }
}
