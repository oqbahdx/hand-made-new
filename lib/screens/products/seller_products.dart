import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/bloc/states.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/products/products_detalis.dart';

import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts(
      {Key key,
      this.uId,
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
  final String uId;

  @override
  _SellerProductsState createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandCubit, HandMadeState>(
      listener: (context, state) {},
      builder: (context, state) {
        double h = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: appBarWidget(
              title: Text(
                '${widget.sellerName} products',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              action: Container(),
              elevation: 20.0),
          body: Container(
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('uId', isEqualTo: widget.uId)
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

                    return GridView(
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
                          onTap: (){
                            moveToPageWithData(context,namePage: ProductDetails(
                              productName: data['name'].toString(),
                              productId: document.id,
                              productDes: data['description'].toString(),
                              productImage: data['image'].toString(),
                              productPrice: data['price'].toString(),
                            ));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  child: Hero(
                                    tag: document.id,
                                    child: FadeInImage(
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(document['image']),
                                      placeholder: const AssetImage(
                                          'assets/pleaceholder.png'),
                                    ),
                                  ),
                                  height: h * 0.16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  document['name'],
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black54,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
