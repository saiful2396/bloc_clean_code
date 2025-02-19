import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:bloc_clean_code/config/color/app_color.dart';
import 'package:flutter/material.dart';

class ExtensionFlushBarHelper{
  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      message: message,
      duration: Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppColors.redColor,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Colors.white,
      ),
    )..show(context));
  }
  static void flushBarSuccessMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      message: message,
      duration: Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppColors.buttonColor,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Colors.white,
      ),
    )..show(context));
  }
}