import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productDes;
  final String productImage;
  const ProductDetails({
    Key key, this.productId, this.productPrice, this.productDes, this.productImage, this.productName,
  }) : super(key: key);
  static String id = "ProductDetails";

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          elevation: 0.0,
          action: Container(),
          title:  Text(
            widget.productName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColor),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Center(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 250,
                width: 250,
                child: Hero(
                  tag: widget.productId,
                  child: Image.network(
                     widget.productImage,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Card(
              color: Colors.transparent,
              elevation: 20.0,
              child: Container(
                height: 55,
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Text(
                      '${widget.productPrice} SDG',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 35,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 20.0,
              color: Colors.transparent,
              child: Container(
                height: 250,
                color: Colors.black54,
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                       widget.productDes,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
