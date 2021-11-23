import 'package:flutter/material.dart';
class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
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