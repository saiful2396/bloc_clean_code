import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bloc_clean_code/config/routes/routes.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      ),
    );
  }
}
