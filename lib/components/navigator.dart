import 'package:flutter/material.dart';


moveToPageWithData(BuildContext context, {Widget namePage}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => namePage));
}