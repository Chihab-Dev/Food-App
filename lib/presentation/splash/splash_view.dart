import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/constants_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:lottie/lottie.dart';

import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPrefrences _appPrefrences = AppPrefrences(instance());

  @override
  void initState() {
    startDelay();
    super.initState();
  }

  Timer? _timer;

  startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
      _goNext();
    });
  }

  _goNext() async {
    _appPrefrences.isOnBoardingScreenViewed().then(
      (isUserViewedOnBoardingScreen) {
        if (isUserViewedOnBoardingScreen) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else {
          Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(LottieAsset.burger),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
