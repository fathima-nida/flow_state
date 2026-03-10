import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/constant/asset_resource.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/auth/controller/auth_controllers.dart';
import 'package:to_do/feature/auth/screens/login.dart';
import 'package:to_do/feature/home/screens/home_screen/home_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double size = 50;
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        size = 250;
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return authState.when(
      loading: () =>
          Scaffold(body: Center(child: Image.asset(AssetResource.logo))),

      error: (e, st) =>
          const Scaffold(body: Center(child: Text('Something went wrong'))),

      data: (isLoggedIn) {
        Future.microtask(() async {
          await Future.delayed(const Duration(seconds: 5, milliseconds: 40));

          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => isLoggedIn ? HomePage() : LoginPage(),
            ),
          );
        });

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                width: size,
                height: size,
          
                child: Image.asset(AssetResource.logo),
              ),
            ),
          ),
        );
      },
    );
  }
}
