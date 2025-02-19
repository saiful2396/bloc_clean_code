import '../../config/app_url.dart';
import '../../data/network/network_services.dart';
import '../../model/user/user_model.dart';
import 'login_repository.dart';

class LoginHttpRepository implements LoginRepository{
  final _api = NetworkServices();

  @override
  Future<UserModel> loginApi(dynamic data) async {
    final response = await _api.postApi(AppUrl.loginApi, data);
    return UserModel.fromJson(response);
  }
}