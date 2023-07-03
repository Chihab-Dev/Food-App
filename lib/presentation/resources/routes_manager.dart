import 'package:flutter/material.dart';
import 'package:food_app/app/di.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin/admin_main/admin_screen_view.dart';
import 'package:food_app/presentation/admin/admin_add_new_meal/view/admin_add_new_meal.dart';
import 'package:food_app/presentation/admin/admin_all_items/admin_all_items.dart';
import 'package:food_app/presentation/admin/admin_all_orders/view/admin_orders_screen_view.dart';
import 'package:food_app/presentation/admin/admin_meal_detail/meal_detail_view.dart';
import 'package:food_app/presentation/admin/admin_order/view/admin_order_view.dart';
import 'package:food_app/presentation/admin/admin_setting/admin_setting_screen.dart';
import 'package:food_app/presentation/favorite/favorite_items_screen.dart';
import 'package:food_app/presentation/meal_detail/view/meal_detail_view.dart';
import 'package:food_app/presentation/meals_by_category/meals_by_category.dart';
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
  static const String adminOrders = "/adminOrders";
  static const String adminAddNewMeal = "/addNewMeal";
  static const String adminMealDetail = "/adminAddNewMeal";
  static const String adminAllItems = "/adminAllItems";
  static const String adminSetting = "/adminSetting";
  static const String mealsByCategory = "/mealsByCategory";
  static const String favorite = "/favorite";
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

      case Routes.adminOrders:
        ClientAllOrders clientAllOrders = settings.arguments as ClientAllOrders;

        return MaterialPageRoute(
            builder: ((context) => AdminOrderView(
                  clientAllOrders: clientAllOrders,
                )));
      case Routes.adminAddNewMeal:
        return MaterialPageRoute(builder: ((context) => const AdminAddNewMeal()));

      case Routes.adminMealDetail:
        AddNewMealObject item = settings.arguments as AddNewMealObject;
        return MaterialPageRoute(
          builder: (context) => AdminMealDetail(item.itemObject, item.file!),
        );

      case Routes.adminAllItems:
        return MaterialPageRoute(builder: ((context) => const AdminAllItems()));

      case Routes.mealsByCategory:
        ItemCategory itemCategory = settings.arguments as ItemCategory;
        return MaterialPageRoute(builder: (context) => MealsByCategoryScreen(itemCategory));

      case Routes.favorite:
        return MaterialPageRoute(builder: ((context) => const FavoriteItemsScreen()));

      case Routes.adminSetting:
        return MaterialPageRoute(builder: (context) => const AdminSetting());

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
