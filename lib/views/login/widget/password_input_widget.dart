import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login/login_bloc.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (current, previous) => current.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          focusNode: passwordFocusNode,
          controller: passwordController,
          decoration: InputDecoration(
              hintText: 'Enter password', border: OutlineInputBorder()),
          onChanged: (val) {
            context.read<LoginBloc>().add(PasswordChange(password: val));
          },
          validator: (val) {
            if (val!.isEmpty) {
              return 'Enter password';
            } else if (val.length < 6) {
              return 'Enter password more than or equal 6 character';
            } else {
              return null;
            }
          },
          onFieldSubmitted: (val) {},
        );
      },
    );
  }
}
