
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class MyProducts extends StatefulWidget {
  static String id = "MyProducts";

  const MyProducts(
      {Key key,
      this.sellerName,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productsCategory})
      : super(key: key);
  final String sellerName;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productsCategory;

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getMyProducts();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = HandCubit.get(context).productsModel;
        return Scaffold(
          appBar: appBarWidget(
              title: const Text(
                'My Products',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              action: Container(),
              elevation: 20.0),
          body: Container(
            padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColor,
              ),
            ),
            child: ConditionalBuilder(
              condition: HandCubit.get(context).myProducts.length >0,
              builder: (context)=>FutureBuilder(builder: (context,index){
                return buildProductsItem(model, '');
              }),
              fallback: (context)=>const Center(child:  CircularProgressIndicator (
                color: Colors.white,
              ),),
            ),
          ));
      },
    );
  }
}
