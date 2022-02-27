import 'package:flutter/material.dart';
import 'package:hand_made_new/chat/seller_chat.dart';

import 'package:hand_made_new/components/containers.dart';
import 'package:hand_made_new/components/navigator.dart';
import 'package:hand_made_new/screens/products/seller_products.dart';

import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

import '../../bloc/cubit.dart';

class SellerDetails extends StatefulWidget {
  final String name;
  final String uId;
  final String image;

  const SellerDetails({Key key, this.name, this.uId, this.image})
      : super(key: key);
  static String id = "SellerDetails";

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandCubit.get(context).getMessages(receiverId: widget.uId);
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
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
                    print(widget.name);
                    print(widget.uId);
                    moveToPageWithData(context,
                        namePage: SellerProducts(
                          sellerName: widget.name,
                          uId: widget.uId,
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
                height: h * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: GestureDetector(
                  onTap: () {
                    moveToPageWithData(
                      context,
                      namePage: SellerChat(
                        image: widget.image,
                        name: widget.name,
                        uid: widget.uId,
                      ),
                    );

                  },
                  child: positionedBuild(
                    h: h * 0.350,
                    w: h * 0.350,
                    txt: "Chat",
                  ),
                ),
              ),
            ],
          ),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
        ),
      ),
    );
  }
}
