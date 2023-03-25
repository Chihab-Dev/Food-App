import 'package:flutter/material.dart';
import 'package:food_app/presentation/login/view/login_view.dart';
import 'package:food_app/presentation/main/view/main_view.dart';
import 'package:food_app/presentation/onBoarding/onboarding_view.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String login = "/login";
  static const String main = "/main";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.main:
        return MaterialPageRoute(builder: (context) => const MainView());
      default:
        return unDefindRoute();
    }
  }

  static Route<dynamic> unDefindRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
