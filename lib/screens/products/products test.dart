import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/models/products_model.dart';

class ProductText extends StatefulWidget {
  const ProductText({Key key}) : super(key: key);
static String id = "ProductText";
  @override
  _ProductTextState createState() => _ProductTextState();
}

class _ProductTextState extends State<ProductText> {
  List<ProductsModel> products = [];
  ProductsModel model;
  bool isOnline = true;
  @override
  void initState() {
    // HandCubit.get(context).getCurrentUserProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Switch.adaptive(value: isOnline, onChanged:(bool value){
          setState(() {
            isOnline = value;
          });
        }),
      ),
    );
  }
}
