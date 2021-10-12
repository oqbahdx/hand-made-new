import 'package:flutter/material.dart';




Widget moveToPageAndFinsh(BuildContext context,Widget pageName){
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>pageName));
}
Widget moveToPage(BuildContext context ,String pageName){
  Navigator.pushNamed(context, pageName);
}