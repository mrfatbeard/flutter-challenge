import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.gr.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/presentation/common/mobx_auto_dispose_mixin.dart';
import 'package:flutter_challenge/presentation/home/home_content.dart';
import 'package:flutter_challenge/presentation/home/home_store.dart';
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

class _HomePageState extends State<HomePage> with MobXAutoDisposeMixin {
  final HomeStore _store = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _store.currentUser = widget.user;
    reaction((_) => _store.currentUser, _redirectToAuth).autoDispose(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) => HomeContent(
          user: _store.currentUser,
          onLogoutPressed: _onLogoutPressed,
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
