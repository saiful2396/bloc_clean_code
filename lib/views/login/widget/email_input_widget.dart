import 'package:bloc_clean_code/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login/login_bloc.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({
    super.key,
    required this.emailController,
    required this.emailFocusNode
  });

  final FocusNode emailFocusNode;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocusNode,
          decoration: InputDecoration(
              hintText: 'Enter email Id', border: OutlineInputBorder()),
          onChanged: (val) {
            context.read<LoginBloc>().add(EmailIdChange(email: val));
          },
          validator: (val) {
            if (val!.isEmpty) {
              return 'Enter email Id';
            }else if(!Validation.emailValidator(val)){
              return 'Enter valid email Id';
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