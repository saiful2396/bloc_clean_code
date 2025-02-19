import 'package:bloc_clean_code/config/routes/routes.dart';
import 'package:bloc_clean_code/utils/api_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../utils/flushbar_helper.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) =>
          current.apiStatus != previous.apiStatus,
      listener: (context, state) {
        if (state.apiStatus == APIStatus.error) {
          if (kDebugMode) {
            print("UI Error Response: ${state.message}");
          }
          ExtensionFlushBarHelper.flushBarErrorMessage(
              state.message.toString(), context);
        }

        if (state.apiStatus == APIStatus.success) {
          if (kDebugMode) {
            print("UI Success Response: ${state.message}");
          }
          Navigator.pushNamed(context, RoutesName.homeScreen);
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (current, previous) =>
            current.apiStatus != previous.apiStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {

              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApi());
              }
            },
            child: state.apiStatus == APIStatus.loading
                ? CircularProgressIndicator()
                : Text("Login"),
          );
        },
      ),
    );
  }
}
