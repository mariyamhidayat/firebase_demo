import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utlis {
  // use flutter toast for exception

  void  toastMessage(message){
    Fluttertoast.showToast(
        msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 15.0,
    );
  }
}