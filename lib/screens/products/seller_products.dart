import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/containers.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getCurrentUserProducts();
    HandCubit.get(context).getSellers();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit,HandMadeState>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: appBarWidget(
              title: Text('seller products',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
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
            child: ConditionalBuilder(
              condition: HandCubit.get(context).products.length>0,
              builder: (context)=>FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').where('uId',
                    isEqualTo: "FlVIm2c0GQMQrH5bEPIxCuLxA342").get(),
                builder: (context,index)=>GridView.builder
                  (
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                      itemBuilder: (context, index) => buildProductsItem(
                      HandCubit.get(context).products[index]
                  ),
                  itemCount: HandCubit.get(context).products.length,
                ),
              ),
              fallback: (context)=>Center(child: Text('No Products',style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
              ),),),
            ),
          ),
        );
      },


    );
  }
}
