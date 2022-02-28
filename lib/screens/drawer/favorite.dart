import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/styles/fonts.dart';
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
              child: ListView.builder(
                itemExtent: 120,
              itemCount: 3,
              itemBuilder: (context,index)=>const Card(
                color: Colors.black87,
                child: Center(
                  child: ListTile(
                    tileColor: Colors.black87,
                    leading: FlutterLogo(),
                    title: Text('One-line with both widgets',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),),
                    trailing: Icon(
                      Icons.favorite_outlined,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
              ), ),
          decoration:
          BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
        ),
      ),
    );
  }
}
