part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class EmailIdChange extends LoginEvent {
  final String email;

  const EmailIdChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class EmailUnFocused extends LoginEvent{}

class PasswordChange extends LoginEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class PasswordUnFocused extends LoginEvent{}
class LoginApi extends LoginEvent{}
