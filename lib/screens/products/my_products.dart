import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/drawer/contact_us.dart';
import 'package:hand_made_new/screens/products/products_detalis.dart';
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
    HandCubit.get(context).getAllFavorites();
    super.initState();
  }

  bool isDrag = false;
  Offset position = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        double h = MediaQuery.of(context).size.height;

        return SafeArea(
          child: Scaffold(
            appBar: appBarWidget(
                title: const Text(
                  'My Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('uId',
                          isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 3.1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 45,
                          ),
                          children: snapshot.data.docs.map((document) {
                            final dynamic data = document.data();
                            return InkWell(
                              onTap: () {
                                moveToPageWithData(context,
                                    namePage: ProductDetails(
                                      productPrice: data['price'].toString(),
                                      productImage: data['image'].toString(),
                                      productDes:
                                          data['description'].toString(),
                                      productId: document.id,
                                      productName: data['name'].toString(),
                                    ));
                                HandCubit.get(context).getAllFavorites();
                              },
                              child: Draggable(
                                onDragUpdate:
                                    (DragUpdateDetails dragUpdateDetails) {},
                                onDragStarted: () {
                                  setState(() {
                                    isDrag = true;
                                  });
                                },
                                onDragCompleted: () {},
                                feedback: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 250,
                                  width: 250,
                                  child: Hero(
                                    tag: document.id,
                                    child: CachedNetworkImage(
                                      imageUrl: data['image'],
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: double.infinity,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/pleaceholder.png',
                                        color: Colors.black87,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red,
                                            spreadRadius: 2.0,
                                            offset: Offset(5.0, 5.0)),
                                        BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: 2.0,
                                            offset: Offset(-5.0, -5.0)),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      )),
                                ),
                                childWhenDragging: const Center(
                                  child: Icon(
                                    Icons.delete,
                                    size: 70,
                                    color: Colors.red,
                                  ),
                                ),
                                onDraggableCanceled: (velocity, offset) {
                                  setState(() {
                                    position = offset;
                                  });
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 250,
                                  width: 250,
                                  child: Hero(
                                    tag: document.id,
                                    child: CachedNetworkImage(
                                      imageUrl: data['image'],
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: double.infinity,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/pleaceholder.png',
                                        color: Colors.black87,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        isDrag
                            ? Positioned(
                                top:MediaQuery.of(context).size.height / 2,
                                left: MediaQuery.of(context).size.width / 3.1,
                                child: DragTarget(

                                  builder: (context,List<dynamic> accepted,
                                      List<dynamic> rejected,)=>const Icon(
                                    Icons.delete,
                                    size: 180,
                                    color: Colors.red,
                                  ),

                                ))
                            : Container()
                      ],
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
