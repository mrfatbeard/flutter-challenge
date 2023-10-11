import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.gr.dart';
import 'package:flutter_challenge/extensions/context_ext.dart';
import 'package:flutter_challenge/presentation/common/adjustable_text_color_text_field.dart';
import 'package:flutter_challenge/presentation/sign_up/sign_up_store.dart';
import 'package:flutter_challenge/themes/text_styles.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final SignUpStore _store = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
    reaction((_) => _store.error, _showError);
    when((_) => _store.user != null, _redirectToHome);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AdjustableTextColorTextField(
            controller: _emailController,
            hintText: "Email",
            style: TextStyles.body1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AdjustableTextColorTextField(
              controller: _usernameController,
              hintText: "Username",
              style: TextStyles.body1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AdjustableTextColorTextField(
              controller: _passwordController,
              obscureText: true,
              hintText: "Password",
              style: TextStyles.body1,
              textInputAction: TextInputAction.go,
              onSubmitted: _onSubmitted,
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmitted(String value) {
    _store.signUpPressed();
  }

  void _onEmailChanged() {
    _store.email = _emailController.text;
  }

  void _onUsernameChanged() {
    _store.username = _usernameController.text;
  }

  void _onPasswordChanged() {
    _store.password = _passwordController.text;
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _usernameController.removeListener(_onUsernameChanged);
    _passwordController.removeListener(_onPasswordChanged);
    super.dispose();
  }

  void _showError(String? error) {
    if (error != null) {
      context.showErrorSnackBar(error);
    }
  }

  void _redirectToHome() {
    AutoRouter.of(context).replaceAll([HomeRoute(user: _store.user!)]);
  }
}
