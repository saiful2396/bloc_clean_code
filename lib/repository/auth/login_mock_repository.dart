import 'package:bloc_clean_code/repository/auth/login_repository.dart';
import '../../model/user/user_model.dart';

class LoginMockRepository implements LoginRepository {
  @override
  Future<UserModel> loginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));

    var response = {'token': 'a23z345xert'};
    return UserModel.fromJson(response);
  }
}
