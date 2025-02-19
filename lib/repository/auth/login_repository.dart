import 'package:bloc_clean_code/model/user/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> loginApi(dynamic data);
}
