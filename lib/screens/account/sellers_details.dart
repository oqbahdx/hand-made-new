import 'package:flutter/material.dart';

import 'package:hand_made_new/bloc/cubit.dart';

import 'package:hand_made_new/components/containers.dart';

import 'package:hand_made_new/styles/colors.dart';
import 'package:hand_made_new/widgets/app_bar.dart';
import 'package:device_preview/device_preview.dart';
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

class _SellerDetailsState extends State<SellerDetails>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    HandCubit.get(context).getSellers();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            appBar: appBarWidget(
              title: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
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
                  Transform(
                    transform: Matrix4.translationValues(
                        0.0, animation.value * w, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left:90),
                      child: PositionedBuild(
                        h: h * 0.080,
                        w: h * 0.080,
                        txt: "Products",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.10,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation.value * w, 0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right:90),
                      child: PositionedBuild(
                        h: h * 0.080,
                        w: h * 0.080,
                        txt: "Time Line",
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradientColor)),
            ),
          );
        },
      ),
    );
  }
}
