import 'dart:convert';

import 'package:bloc_clean_code/model/user/user_model.dart';
import 'package:bloc_clean_code/service/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();

  final LocalStorage localStorage = LocalStorage();
  UserModel user = UserModel();
  bool? isLogin;

  // protect to create multiple instance
  SessionController._internal() {
    isLogin = false;
  }

  factory SessionController() {
    return _session;
  }

  Future<void> saveUserInPreference(dynamic user) async {
    localStorage.setValue('token', jsonEncode(user));

    // store value to check login
    localStorage.setValue('isLogin', 'true');
  }

  Future<void> getUserFromPreference() async {
    var userData = await localStorage.readValue('token');
    var isLogin = await localStorage.readValue('isLogin');

    try{
      if(userData != ''){
        SessionController().user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == 'true' ? true : false;

    }catch(e){
      debugPrint(e.toString());
    }
  }
}
