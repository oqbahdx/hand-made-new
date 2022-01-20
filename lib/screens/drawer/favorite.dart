import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);
  static String id = "FavoritePage";
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
            title: const Text('Favorite',style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
            elevation: 0.0,
            action: Container()
        ),
        body: Container(
          child: const Center(
            child: Text('Favorite',style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
            ),),
          ),
          decoration:
          BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
        ),
      ),
    );
  }
}
