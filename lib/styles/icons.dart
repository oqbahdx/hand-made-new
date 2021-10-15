import 'package:flutter/material.dart';
import 'package:hand_made_new/styles/colors.dart';
class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        radius: 0.5,
        colors:[
          Colors.green,
          Colors.black,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}