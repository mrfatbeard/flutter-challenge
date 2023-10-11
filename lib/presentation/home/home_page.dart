import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.gr.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/presentation/home/home_store.dart';
import 'package:flutter_challenge/themes/text_styles.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _store = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _store.currentUser = widget.user;
    reaction((_) => _store.currentUser, _redirectToAuth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final user = _store.currentUser;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: DefaultTextStyle(
        style: TextStyles.h6.copyWith(color: colorScheme.onBackground),
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
              child: TextButton(onPressed: _onLogoutPressed, child: const Text("Logout")),
            ),
          ],
        ),
      ),
    );
  }

  void _onLogoutPressed() {
    _store.logout();
  }

  void _redirectToAuth(User? user) {
    if (user == null) {
      AutoRouter.of(context).replaceAll([const AuthRoute()]);
    }
  }
}
