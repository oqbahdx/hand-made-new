import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessageSuccess(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.teal,
  );
}

showMessageError(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.red,
  );
}
