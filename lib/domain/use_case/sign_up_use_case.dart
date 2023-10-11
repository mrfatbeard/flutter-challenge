import 'package:equatable/equatable.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/user_already_exists_error.dart';
import 'package:flutter_challenge/domain/errors/username_already_taken_error.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase implements UseCase<SignUpParams, User> {
  final UserStorage _userStorage;

  SignUpUseCase(this._userStorage);

  @override
  Future<User> execute(SignUpParams? params) async {
    final ensureParams = ArgumentError.checkNotNull(params, "SignUpParams");
    final email = ensureParams.email;
    final emailTaken = await _userStorage.isEmailTaken(email: email);
    if (emailTaken) {
      throw UserAlreadyExistsError();
    }

    final username = ensureParams.username;
    final usernameTaken = await _userStorage.isUsernameTaken(username: username);
    if (usernameTaken) {
      throw UsernameAlreadyTakenError();
    }
    final user = await _userStorage.storeUser(email: email, username: username, password: ensureParams.password);
    await _userStorage.loginUser(user);
    return user;
  }
}

class SignUpParams with EquatableMixin {
  final String email;
  final String username;
  final String password;

  const SignUpParams({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}
