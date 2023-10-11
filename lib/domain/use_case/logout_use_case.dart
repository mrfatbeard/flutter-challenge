import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase implements UseCase<dynamic, void> {
  final UserStorage _userStorage;

  LogoutUseCase(this._userStorage);

  @override
  Future<void> execute(params) {
    return _userStorage.logout();
  }
}