import 'package:flutter_challenge/domain/entity/user.dart';

abstract interface class UserStorage {
  Future<User> storeUser({required String email, required String username, required String password});

  Future<User?> getUser({required String username});

  Future<bool> isEmailTaken({required String email});

  Future<bool> isUsernameTaken({required String username});

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<void> loginUser(User user);
}
