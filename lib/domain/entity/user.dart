import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  final String email;
  final String username;
  final String password;

  const User({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}
