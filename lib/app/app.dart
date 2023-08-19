import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/app/di.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key});

  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPrefrences appPrefrences = instance<AppPrefrences>();
  String? initRoute;

  _getInitRoute() async {
    bool userLoggedIn = await appPrefrences.isUserLoggedIn();
    if (userLoggedIn) {
      initRoute = Routes.main;
      return;
    }

    bool onBoardingViewed = await appPrefrences.isOnBoardingScreenViewed();
    if (onBoardingViewed) {
      initRoute = Routes.login;
    } else {
      initRoute = Routes.onBoardingRoute;
    }
  }

  @override
  void initState() {
    _getInitRoute();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BaseCubit()
            ..getUserData()
            ..getCurrentLocation()
            ..getItems()
            ..getPopularItems()
            ..getIsStoreOpen()
            ..getOrderId()
            ..requestPermission(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.local,
            onGenerateRoute: RoutesGenerator.getRoute,
            // initialRoute: Routes.splashRoute,
            initialRoute: initRoute ?? Routes.splashRoute,
            theme: getApplicationTheme(),
          );
        },
      ),
    );
  }
}
