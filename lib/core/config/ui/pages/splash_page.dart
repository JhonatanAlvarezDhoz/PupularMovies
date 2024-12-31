import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/constants/app_sizes.dart';
import 'package:popular_movies/core/widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  get milliseconds => null;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      // in this point you can add functionality for init or validadte sesion
      // Navigator.of(context).pushReplacementNamed(AppRoutes.baseePage);
      validateSession();
    });
    super.initState();
  }

  Future<void> validateSession() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      context.go("/base");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: AnimatedEntryWidget(
                duration: const Duration(milliseconds: 4000),
                type: AnimationType.fadeIn,
                child: Image.asset(
                  "assets/images/logo.jpg",
                  width: 280,
                )),
          ),
          gapH20,
          const AnimatedLoadingBar(
              width: 270,
              progressColor: Color((0xffff4654)),
              duration: Duration(
                milliseconds: 3800,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
