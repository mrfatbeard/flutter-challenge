import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/user_already_exists_error.dart';
import 'package:flutter_challenge/domain/errors/username_already_taken_error.dart';
import 'package:flutter_challenge/domain/use_case/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'sign_up_store.g.dart';

@injectable
class SignUpStore = SignUpStoreBase with _$SignUpStore;

abstract class SignUpStoreBase with Store {
  final SignUpUseCase _signUpUseCase;

  SignUpStoreBase(this._signUpUseCase);

  @observable
  String email = "";

  @observable
  String username = "";

  @observable
  String password = "";

  @observable
  User? user;

  @observable
  String? error;

  @action
  Future<void> signUpPressed() async {
    error = _validateInput();
    if (error != null) {
      return;
    }
    try {
      user = await _signUpUseCase.execute(SignUpParams(email: email, username: username, password: password));
    } on UserAlreadyExistsError {
      error = "User with email $email already exists";
    } on UsernameAlreadyTakenError {
      error = 'Username "$username" already taken';
    }
  }

  String? _validateInput() {
    if (email.isEmpty) {
      return "Email should not be empty";
    }

    if (!isEmail(email)) {
      return "Invalid email";
    }

    if (username.isEmpty) {
      return "Username should not be empty";
    }

    if (password.isEmpty) {
      return "Password should not be empty";
    }

    return null;
  }
}
