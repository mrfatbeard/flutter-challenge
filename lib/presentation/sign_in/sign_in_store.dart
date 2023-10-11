import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/incorrect_username_or_password_error.dart';
import 'package:flutter_challenge/domain/use_case/sign_in_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'sign_in_store.g.dart';

@injectable
class SignInStore = SignInStoreBase with _$SignInStore;

abstract class SignInStoreBase with Store {
  final SignInUseCase _signInUseCase;

  SignInStoreBase(this._signInUseCase);

  @observable
  String username = "";

  @observable
  String password = "";

  @observable
  User? user;

  @observable
  String? error;

  @action
  Future<void> signInPressed() async {
    error = _validateInput();
    if (error != null) {
      return;
    }
    try {
      user = await _signInUseCase.execute(SignInParams(username: username, password: password));
    } on IncorrectUsernameOrPasswordError {
      error = "Incorrect username or password";
    }
  }

  String? _validateInput() {
    if (username.isEmpty) {
      return "Username should not be empty";
    }

    if (password.isEmpty) {
      return "Password should not be empty";
    }

    return null;
  }
}
