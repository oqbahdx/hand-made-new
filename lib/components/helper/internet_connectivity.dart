import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';


class InternetConnectivity extends StatefulWidget {
  const InternetConnectivity({Key key}) : super(key: key);

  @override
  _InternetConnectivityState createState() => _InternetConnectivityState();
}

class _InternetConnectivityState extends State<InternetConnectivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/wifi.png'),
                const Text('NO INTERNET CONNCTION ',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
