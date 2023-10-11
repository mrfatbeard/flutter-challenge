import 'package:flutter_challenge/data/entity/user_entity.dart';
import 'package:flutter_challenge/domain/entity/user.dart';

extension UserMapper on UserEntity {
  User toUser() => User(email: email, username: username, password: password);
}