import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/account/sellers_details.dart';
import 'package:hand_made_new/screens/drawer/contact_us.dart';
import 'package:hand_made_new/screens/drawer/favorite.dart';
import 'package:hand_made_new/screens/home/profile.dart';
import 'package:hand_made_new/screens/home/chat_list.dart';
import 'package:hand_made_new/screens/products/my_products.dart';
import 'package:hand_made_new/screens/products/products%20test.dart';
import 'package:hand_made_new/screens/products/products_detalis.dart';

import 'package:hand_made_new/storage/shared.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

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
    return BlocProvider<HandCubit>(
      create: (context) => HandCubit()..getCurrentUser(),
      lazy: true,
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        theme: ThemeData(
          fontFamily: 'Amiri',
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: ProductTest.id,
        home: startPage,
        routes: {
          OnBoarding.id: (_) => const OnBoarding(),

          StartPage.id: (context) => const StartPage(),
          MapPage.id: (context) => const MapPage(),
          AddProduct.id: (context) => const AddProduct(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterMainPage.id: (context) => const RegisterMainPage(),
          SellerRegisterPage.id: (context) => const SellerRegisterPage(),
          BuyerRegisterPage.id: (context) => const BuyerRegisterPage(),
          OTPPage.id: (context) => const OTPPage(),
          VerifyOtp.id: (context) => const VerifyOtp(),
          SellerDetails.id: (context) => const SellerDetails(),
          Profile.id: (context) => const Profile(),
          MyProducts.id: (context) => const MyProducts(),
          ProductTest.id: (context) => const ProductTest(),
          ContactUs.id: (context) => const ContactUs(),
          FavoritePage.id: (context) => const FavoritePage(),
          ChatList.id: (context) => const ChatList(),
          ProductDetails.id: (context) => const ProductDetails()
        },
      ),
    );
  }
}
