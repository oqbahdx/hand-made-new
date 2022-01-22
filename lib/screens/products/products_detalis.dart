import 'package:flutter/material.dart';
import 'package:hand_made_new/bloc/cubit.dart';
import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key key,
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
          title: const Text(
            'Product Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColor),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 0,
            ),
            Image.network(
                'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
            SizedBox(
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
                  children: const [
                    Text(
                      '2500 SDG',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Icon(
                      Icons.favorite_border,
                      size: 35,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 20.0,
              color: Colors.transparent,
              child: Container(
                height: 250,
                color: Colors.black54,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '11111111111111111111111111111111111111111111111111111111111111111111111111',
                    style: TextStyle(
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
