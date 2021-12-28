import 'package:flutter/material.dart';

import 'package:hand_made_new/bloc/cubit.dart';

import 'package:hand_made_new/components/containers.dart';

import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';

class SellerDetails extends StatefulWidget {
  final String name;

  const SellerDetails({
    Key key,
    this.name,
  }) : super(key: key);
  static String id = "SellerDetails";

  @override
  _SellerDetailsState createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  @override
  void initState() {
    HandCubit.get(context).getSeller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 10.0,
          action: Container(),
        ),
        body: Container(
          child: Stack(
            children: [
              PositionedBuild(
                h: h * 0.080,
                w: w * 0.090,
                txt: "Products",
              ),
              PositionedBuild(
                h: h * 0.48,
                w: w * 0.25,
                txt: "Time Line",
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
