import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/core/extensions.dart';

class ToastUtils {
  static show({
    required String msg,
    Toast length = Toast.LENGTH_SHORT,
    ToastType type = ToastType.message,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: type.getColor(),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static hide() {
    Fluttertoast.cancel();
  }
}
