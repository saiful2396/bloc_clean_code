import 'package:bloc_clean_code/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_clean_code/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(loginRepository: getIt());
    setState(() {
      _emailController.text = 'eve.holt@reqres.in';
      _passwordController.text = 'cityslicka';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailInputWidget(
                    emailController: _emailController,
                    emailFocusNode: emailFocusNode),
                SizedBox(height: 20),
                PasswordInputWidget(
                    passwordController: _passwordController,
                    passwordFocusNode: passwordFocusNode),
                SizedBox(height: 50),
                LoginButtonWidget(formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
