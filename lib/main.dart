import 'package:flutter/material.dart';
import 'package:flutter_challenge/app_router.dart';
import 'package:flutter_challenge/data/entity/user_entity.dart';
import 'package:flutter_challenge/di/injection.dart';
import 'package:flutter_challenge/themes/dark_theme.dart';
import 'package:flutter_challenge/themes/light_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(theme: lightTheme, darkTheme: darkTheme, routerConfig: _appRouter.config());
  }
}
