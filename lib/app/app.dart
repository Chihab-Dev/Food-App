import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BaseCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.local,
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
