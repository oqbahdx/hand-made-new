import 'package:flutter/material.dart';



import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/products/seller_products.dart';

import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class SellerDetails extends StatefulWidget {
  final String name;
  final String uId;

  const SellerDetails({Key key, this.name, this.uId}) : super(key: key);
  static String id = "SellerDetails";

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails>
     {




  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(

          child: Scaffold(
            appBar: appBarWidget(
              title: Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 10.0,
              action: Container(),
            ),
            body: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: GestureDetector(
                      onTap: () {
                        moveToPageWithData(context,
                            namePage: SellerProducts(
                              sellerName: widget.name,
                              uId: widget.uId,
                              // productImage: ,
                              // productName: ,
                              // productPrice: ,
                              // productsCategory: ,
                            ));
                      },
                      child: positionedBuild(
                        h: h * 0.350,
                        w: h * 0.350,
                        txt: "Products",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: positionedBuild(
                      h: h * 0.350,
                      w: h * 0.350,
                      txt: "Time Line",
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
            ),
          ),
      );

  }
}
