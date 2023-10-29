import 'package:flutter/material.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/themes/text_styles.dart';

class HomeContent extends StatelessWidget {
  final User? user;
  final VoidCallback onLogoutPressed;

  const HomeContent({super.key, required this.user, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyles.h6.copyWith(color: Theme.of(context).colorScheme.onBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${user?.email}"),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text("Username: ${user?.username}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text("Password: ${user?.password}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextButton(onPressed: onLogoutPressed, child: const Text("Logout")),
            ),
          ],
        ),
      ),
    );
  }
}
