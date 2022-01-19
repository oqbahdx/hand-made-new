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
  @override
  void initState() {
    // HandCubit.get(context).getCurrentUserProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit,HandMadeState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is !HandGetCurrentUserProductsLoadingState,
              builder: (context)=>FutureBuilder(
                  future: FirebaseFirestore.instance.collection('/products').get().then((value){
                    for (var element in value.docs) {
                      products.add(ProductsModel.fromJson(element.data()));
                    }
                    if (kDebugMode) {
                      print(products[2].name);
                    }
                  }),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      // return  buildProductsItem(
                      //     model
                      // );
                      Text(products[2].name,style: const TextStyle(
                        fontSize: 50
                      ),);
                    }
                    return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 45),
                        itemBuilder: (context,index)=> buildProductsItem(
                          products[index],
                          products[index],
                        ),
                        itemCount: products.length,);
                  }


              ),
              fallback:(context)=> const Center(child: Text("No Products"),),
            ),
          ),
        );
      },

    );
  }
}
