import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:flutter_challenge/domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUserUseCase implements UseCase<dynamic, User?> {
  final UserStorage _userStorage;

  GetCurrentUserUseCase(this._userStorage);

  @override
  Future<User?> execute(params) {
    return _userStorage.getCurrentUser();
  }
}
