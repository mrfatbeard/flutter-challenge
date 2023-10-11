import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/gen/assets.gen.dart';
import 'package:flutter_challenge/presentation/common/rounded_tab_bar.dart';
import 'package:flutter_challenge/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_challenge/presentation/sign_up/sign_up_page.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Assets.graphics.bg.svg(
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 54, left: 24),
              child: Assets.graphics.logo.svg(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 162,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        SignInPage(),
                        SignUpPage(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                    height: 40,
                    child: RoundedTabBar(
                      tabController: _tabController,
                      onTap: _navigateToPage,
                      tabs: const [Text("Login"), Text("Sign up")],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 42),
                    height: 40,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot password?"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
