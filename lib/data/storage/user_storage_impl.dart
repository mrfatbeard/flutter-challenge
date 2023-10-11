import 'package:flutter_challenge/data/entity/user_entity.dart';
import 'package:flutter_challenge/data/mapper/user_mapper.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/domain/storage/user_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserStorage)
class UserStorageImpl implements UserStorage {
  static const _userBoxName = "userBox";
  static const _lastLoggedInBoxName = "lastLoggedIn";
  static const _lastLoggedInKey = "lastLoggedInUsername";

  @override
  Future<User?> getUser({required String username}) async {
    final box = await Hive.openBox<UserEntity>(_userBoxName);
    return box.get(username)?.toUser();
  }

  @override
  Future<bool> isEmailTaken({required String email}) async {
    final box = await Hive.openBox<UserEntity>(_userBoxName);
    return box.values.map((e) => e.email).contains(email);
  }

  @override
  Future<bool> isUsernameTaken({required String username}) async {
    final box = await Hive.openBox<UserEntity>(_userBoxName);
    return box.containsKey(username);
  }

  @override
  Future<User> storeUser({
    required String email,
    required String username,
    required String password,
  }) async {
    final userBox = await Hive.openBox<UserEntity>(_userBoxName);
    final userEntity = UserEntity(email: email, username: username, password: password);
    await userBox.put(username, userEntity);
    return userEntity.toUser();
  }

  @override
  Future<void> logout() async {
    final box = await Hive.openBox(_lastLoggedInBoxName);
    return box.delete(_lastLoggedInKey);
  }

  @override
  Future<User?> getCurrentUser() async {
    final box = await Hive.openBox(_lastLoggedInBoxName);
    final String? lastLoggedInUsername = box.get(_lastLoggedInKey);
    if (lastLoggedInUsername == null) {
      return null;
    }
    final userBox = await Hive.openBox<UserEntity>(_userBoxName);
    final user = userBox.get(lastLoggedInUsername);
    return user?.toUser();
  }

  @override
  Future<void> loginUser(User user) async {
    final lastLoggedInBox = await Hive.openBox(_lastLoggedInBoxName);
    lastLoggedInBox.put(_lastLoggedInKey, user.username);
  }
}
