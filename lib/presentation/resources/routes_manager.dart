import 'package:flutter/material.dart';
import 'package:food_app/app/di.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin/view/admin_screen_view.dart';
import 'package:food_app/presentation/admin_all_order/view/admin_orders_screen_view.dart';
import 'package:food_app/presentation/admin_order/view/admin_order_view.dart';
import 'package:food_app/presentation/mealDetail/view/meal_detail_view.dart';
import 'package:food_app/presentation/signin/view/signin_view.dart';
import 'package:food_app/presentation/main/main_view.dart';
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
  static const String mealDetail = "/mealDetail";
  static const String admin = "/admin";
  static const String adminAllOrders = "/adminAllOrders";
  static const String adminOrder = "/adminOrder";
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
        initHomeData();
        return MaterialPageRoute(builder: (context) => const MainView());
      case Routes.register:
        RegisterViewParamters parameters = settings.arguments as RegisterViewParamters;
        return MaterialPageRoute(
            builder: (context) => RegisterView(phoneNumber: parameters.phoneNumber, uid: parameters.uid));
      case Routes.mealDetail:
        ItemObject item = settings.arguments as ItemObject;
        return MaterialPageRoute(
          builder: (context) => MealDetailScreen(item),
        );
      case Routes.admin:
        return MaterialPageRoute(builder: ((context) => const AdminScreenView()));
      case Routes.adminAllOrders:
        return MaterialPageRoute(builder: ((context) => const AdminAllOrdersView()));
      case Routes.adminOrder:
        ClientAllOrders clientAllOrders = settings.arguments as ClientAllOrders;
        return MaterialPageRoute(
            builder: ((context) => AdminOrderView(
                  clientAllOrders: clientAllOrders,
                )));
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
