import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/screens/home/map.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/screens/intro/onBoarding.dart';
import 'package:hand_made_new/screens/products/add_product.dart';
import 'package:hand_made_new/state_management/cubit.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(

      MyApp(
  ));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>HandCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Amiri',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: StartPage.id,
        routes: {
          OnBoarding.id:(context)=>OnBoarding(),
          StartPage.id:(context)=>StartPage(),
          MapPage.id:(context)=>MapPage(),
          AddProduct.id:(context)=>AddProduct(),
        },
      ),
    );
  }
}
