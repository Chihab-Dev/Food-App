import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key});

  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.local,
      onGenerateRoute: (settings) => RoutesGenerator.getRoute(settings),
      initialRoute: Routes.onBoardingRoute,
    );
  }
}
