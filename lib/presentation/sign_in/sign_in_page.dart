import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.gr.dart';
import 'package:flutter_challenge/extensions/context_ext.dart';
import 'package:flutter_challenge/presentation/common/adjustable_text_color_text_field.dart';
import 'package:flutter_challenge/presentation/sign_in/sign_in_store.dart';
import 'package:flutter_challenge/themes/text_styles.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final SignInStore _store = GetIt.I.get();

  @override
  void initState() {
    super.initState();
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
            controller: _usernameController,
            hintText: "Username",
            style: TextStyles.body1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AdjustableTextColorTextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyles.body1,
              hintText: "Password",
              textInputAction: TextInputAction.go,
              onSubmitted: _onSubmitted,
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmitted(String value) {
    _store.signInPressed();
  }

  void _onUsernameChanged() {
    _store.username = _usernameController.text;
  }

  void _onPasswordChanged() {
    _store.password = _passwordController.text;
  }

  @override
  void dispose() {
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
