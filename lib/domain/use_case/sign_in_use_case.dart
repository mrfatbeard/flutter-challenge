import 'package:equatable/equatable.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/errors/incorrect_username_or_password_error.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUseCase implements UseCase<SignInParams, User> {
  final UserStorage _userStorage;

  SignInUseCase(this._userStorage);

  @override
  Future<User> execute(SignInParams? params) async {
    final ensureParams = ArgumentError.checkNotNull(params);
    final user = await _userStorage.getUser(username: ensureParams.username);
    if (user == null) {
      throw IncorrectUsernameOrPasswordError();
    }

    if (user.password != ensureParams.password) {
      throw IncorrectUsernameOrPasswordError();
    }
    await _userStorage.loginUser(user);
    return user;
  }
}

class SignInParams with EquatableMixin {
  final String username;
  final String password;

  const SignInParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
