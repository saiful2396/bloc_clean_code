import 'package:bloc/bloc.dart';
import 'package:bloc_clean_code/repository/auth/login_repository.dart';
import 'package:bloc_clean_code/service/session/session_controller.dart';
import 'package:bloc_clean_code/utils/api_status.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
    on<EmailIdChange>(_onEmailChanged);
    on<PasswordChange>(_onPasswordChanged);
    on<LoginApi>(_onLoginApi);
  }

  void _onEmailChanged(EmailIdChange event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChange event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginApi(LoginApi event, Emitter<LoginStates> emit) async {
    Map<String, String> data = {
      'email': state.email,
      'password': state.password,
    };

    emit(
      state.copyWith(apiStatus: APIStatus.loading),
    );

    await loginRepository.loginApi(data).then((value) async {
      if (value.error.isNotEmpty) {
        emit(
          state.copyWith(
              message: value.error.toString(), apiStatus: APIStatus.error),
        );
      } else {

        await SessionController().saveUserInPreference(value);
        await SessionController().getUserFromPreference();

        emit(
          state.copyWith(
              message: 'Login Success', apiStatus: APIStatus.success),
        );
      }
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(message: error.toString(), apiStatus: APIStatus.error),
      );
    });
  }
}
