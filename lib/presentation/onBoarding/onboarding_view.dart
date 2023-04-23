import 'package:flutter/material.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../app/di.dart';
import '../resources/appsize.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final AppPrefrences _appPrefrences = AppPrefrences(instance());
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      bodyPadding: const EdgeInsets.symmetric(vertical: AppPadding.p100, horizontal: AppPadding.p2),
      globalBackgroundColor: ColorManager.whiteGrey,
      pages: pagesList,
      done: const Text(
        AppStrings.onBoardingDone,
      ),
      onDone: () async {
        _appPrefrences.setOnBoardingScreenViewed();
        Navigator.pushReplacementNamed(context, Routes.login);
      },
      doneStyle: TextButton.styleFrom(foregroundColor: ColorManager.orange),
      showSkipButton: true,
      skip: const Text(
        AppStrings.skip,
      ),
      skipStyle: TextButton.styleFrom(foregroundColor: ColorManager.orange),
      showNextButton: true,
      next: Icon(
        Icons.arrow_forward_ios_rounded,
        color: ColorManager.orange,
        size: AppSize.s25,
      ),
      nextFlex: 0,
      skipOrBackFlex: 0,
      nextStyle: TextButton.styleFrom(foregroundColor: ColorManager.orange),
      isTopSafeArea: true,
      dotsDecorator: getDotsDecoration(),
    );
  }

  DotsDecorator getDotsDecoration() {
    return DotsDecorator(
      color: ColorManager.ligthGrey,
      size: const Size.square(AppSize.s10),
      activeColor: ColorManager.orange,
      activeSize: const Size(20, 10),
      spacing: const EdgeInsets.symmetric(horizontal: AppSize.s5),
      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s20)),
    );
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      titleTextStyle: getlargeStyle(color: ColorManager.black),
      bodyTextStyle: getMeduimStyle(color: ColorManager.grey),
    );
  }

  late List<PageViewModel> pagesList = [
    PageViewModel(
      image: Lottie.asset(LottieAsset.pizza),
      title: AppStrings.pizza.toUpperCase(),
      body: AppStrings.pizzaDescription,
      decoration: getPageDecoration(),
    ),
    PageViewModel(
      image: Lottie.asset(LottieAsset.burger),
      title: AppStrings.burger.toUpperCase(),
      body: AppStrings.burgerDescription,
      decoration: getPageDecoration(),
    ),
    PageViewModel(
      image: Lottie.asset(LottieAsset.delivery),
      title: AppStrings.delivery.toUpperCase(),
      body: AppStrings.deliveryDescription,
      decoration: getPageDecoration(),

      // footer: ElevatedButton(
      //   onPressed: () {
      //     // On button pressed
      //   },
      //   child: const Text("Let's Go!"),
      // ),
    ),
  ];
}
