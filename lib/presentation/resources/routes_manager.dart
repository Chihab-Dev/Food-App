import 'package:flutter/material.dart';
import 'package:food_app/presentation/signin/view/signin_view.dart';
import 'package:food_app/presentation/main/view/main_view.dart';
import 'package:food_app/presentation/onBoarding/onboarding_view.dart';
import 'package:food_app/presentation/otp/view/otp_view.dart';
import 'package:food_app/presentation/register/view/register_view.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String register = "/register";
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
        return MaterialPageRoute(builder: (context) => const SigninView());
      case Routes.otp:
        String parameters = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => OtpView(verificationId: parameters));
      case Routes.main:
        return MaterialPageRoute(builder: (context) => const MainView());
      case Routes.register:
        RegisterViewParamters parameters = settings.arguments as RegisterViewParamters;
        return MaterialPageRoute(
            builder: (context) =>
                RegisterView(phoneNumber: parameters.phoneNumber, uid: parameters.uid));
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

class RegisterViewParamters {
  String phoneNumber;
  String uid;

  RegisterViewParamters(this.phoneNumber, this.uid);
}
