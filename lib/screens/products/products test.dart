import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTest extends StatefulWidget {
  static String id = "ProductTest";

  const ProductTest({Key key}) : super(key: key);

  @override
  _ProductTestState createState() => _ProductTestState();
}

class _ProductTestState extends State<ProductTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 250,
          width: 250,
          child: Image.network(
            'https://images.unsplash.com/photo-1506354666786-959d6d497f1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
