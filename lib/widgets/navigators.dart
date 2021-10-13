import 'package:flutter/material.dart';

moveToPageAndFinish(BuildContext context, Widget pageName) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => pageName));
}

moveToPage(BuildContext context, String pageName) {
  Navigator.pushNamed(context, pageName);
}
