import 'package:flutter/material.dart';
import 'package:hand_made_new/screens/home/start.dart';
import 'package:hand_made_new/screens/intro/onBoarding.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(

      MyApp(
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartPage.id,
      routes: {
        OnBoarding.id:(context)=>OnBoarding(),
        StartPage.id:(context)=>StartPage(),
      },
    );
  }
}
