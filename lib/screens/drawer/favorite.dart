import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/components/show_message.dart';
import 'package:hand_made_new/screens/products/products_detalis.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/styles/fonts.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

import '../../components/containers.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);
  static String id = "FavoritePage";

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    HandCubit.get(context).getAllFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {
        if (state is HandDeleteFavoriteItemSuccess) {
          showMessageError('Item has been deleted successfully');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: appBarWidget(
              title: Text(
                'My Favorites',
                style: appBarStyle,
              ),
              elevation: 0.0,
              action: Container()),
          body: ConditionalBuilder(
            condition: state is! HandGetUserSuccessState,
            builder: (context) => Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: gradientColor,
                )),
                child:FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('favorites').where('userId',isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    return ListView(
                      itemExtent: 120,
                      children: snapshot.data.docs.map((document) {
                        final dynamic data = document.data();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              moveToPageWithData(context,
                                  namePage: ProductDetails(
                                    productId: document.id,
                                    productPrice: document['productPrice'],
                                    productImage: document['productImage'],
                                    productDes: document['productDes'],
                                    productName: document['productName'],
                                  ));
                            },
                            child: Dismissible(
                              direction: DismissDirection.horizontal,
                              key: UniqueKey(),
                              onDismissed: (DismissDirection direction){
                                HandCubit.get(context).deleteFavoriteItem(productId: document.id);
                              },
                              child: favoriteBuild(
                                  image: document['productImage'],
                                  name: document['productName'],
                                  tag: document.id),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),),
            fallback: (context) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
