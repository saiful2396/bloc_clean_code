import 'dart:async';
import 'package:bloc_clean_code/service/session/session_controller.dart';
import 'package:flutter/material.dart';

import 'package:bloc_clean_code/config/routes/routes.dart';

class SplashServices {
  void isLogin(BuildContext context) {

    SessionController().getUserFromPreference().then((value){

      if(SessionController().isLogin ?? false){
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.homeScreen,
                (route) => false,
          ),
        );
      }else{
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.loginScreen,
                (route) => false,
          ),
        );
      }

    }).onError((error, stackStrace){
      Timer(
        Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.loginScreen,
              (route) => false,
        ),
      );
    });


  }
}
