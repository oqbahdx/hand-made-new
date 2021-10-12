import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';


class AddProduct extends StatefulWidget {
  static String id = "AddProduct";

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: Text('Add Product',style: normalText,),
        action: Container(),
        elevation: 0.0
      ),
      body: Center(
        child: Text('Add Product'),
      ),
    );
  }
}
