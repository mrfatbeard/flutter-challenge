import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;

  const UserEntity({
    required this.email,
    required this.username,
    required this.password,
  });
}
