import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({Key key, this.sellerName, this.productName, this.productImage, this.productPrice, this.productsCategory}) : super(key: key);
 final String sellerName;
 final String productName;
 final String productImage;
 final String productPrice;
 final String productsCategory;
  @override
  _SellerProductsState createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit,HandMadeState>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: appBarWidget(
              title: Text('seller products'),
              action: Container(),
              elevation: 20.0
          ),
          body: Container(
            padding: EdgeInsets.only(top: 15,right: 5,left: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColor,
              ),
            ),
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
            ),
              itemBuilder: (context,index)=>Container(
                height: 300,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),itemCount: 5,),
          ),
        );
      },


    );
  }
}
