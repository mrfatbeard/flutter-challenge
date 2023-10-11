import 'package:auto_route/auto_route.dart';
import 'package:flutter_challenge/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, initial: true),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
