import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../main.dart';

class DialogUtils {
  DialogUtils._();

  static void showConfirmationDialog({
    required BuildContext ctx,
    String? title,
    String? desc,
    String? positiveBtnText,
    String? negativeBtnText,
    Function()? onPositiveBtnPressed,
    Function()? onNegativeBtnPressed,
  }) {
    AwesomeDialog(
      context: ctx,
      dismissOnTouchOutside: false,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkText: positiveBtnText,
      btnCancelText: negativeBtnText,
      btnCancelOnPress: onNegativeBtnPressed ?? () {},
      btnOkOnPress: onPositiveBtnPressed,
    ).show();
  }

  static Future<dynamic> showErrorDialog({
    required BuildContext ctx,
    String? title,
    String? desc,
    String? positiveBtnText,
    String? negativeBtnText,
    Function()? onPositiveBtnPressed,
  }) {
    final dialog = AwesomeDialog(
      context: ctx,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: onPositiveBtnPressed,
    ).show();
    return dialog;
  }

  static Future<dynamic> showInfoDialog({
    required BuildContext ctx,
    String? title,
    String? desc,
    String? positiveBtnText,
    Function()? onPositiveBtnPressed,
  }) {
    final dialog = AwesomeDialog(
      context: ctx,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: onPositiveBtnPressed,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    ).show();
    return dialog;
  }
}
