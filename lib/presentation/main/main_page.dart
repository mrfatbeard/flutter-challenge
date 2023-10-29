import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.gr.dart';
import 'package:flutter_challenge/domain/entity/user.dart';
import 'package:flutter_challenge/presentation/common/mobx_auto_dispose_mixin.dart';
import 'package:flutter_challenge/presentation/main/main_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MobXAutoDisposeMixin {
  final MainStore _store = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await _store.checkLogin();
    autorun((_) => _redirect(_store.currentUser)).autoDispose(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
    );
  }

  void _redirect(User? user) {
    if (user == null) {
      AutoRouter.of(context).replaceAll([const AuthRoute()]);
      return;
    }
    AutoRouter.of(context).replaceAll([HomeRoute(user: user)]);
  }
}
