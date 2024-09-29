import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Toast {
  static successToast (String msg){
    Fluttertoast.showToast(
        msg: msg,
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static errorToast (String msg){
    Fluttertoast.showToast(
        msg: msg,
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}