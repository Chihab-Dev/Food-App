import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_cubit.dart';
import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/font_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = OnBoardingCubit.get(context);
          var sliderObject = cubit.sliderObject[cubit.currentIndex];
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(sliderObject.image),
                  Text(
                    sliderObject.title,
                    style: const TextStyle(
                      fontSize: FontSize.s30,
                    ),
                  ),
                  const SizedBox(height: AppSize.s15),
                  Text(
                    sliderObject.subTitle,
                    style: const TextStyle(
                      fontSize: FontSize.s14,
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              color: ColorManager.orange,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.goPrevious();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorManager.white,
                        size: AppSize.s25,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < cubit.sliderObject.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: _getProperCircle(i, cubit.currentIndex),
                          ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.goNext();
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorManager.white,
                        size: AppSize.s25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _getProperCircle(int index, int currentindex) {
    if (index == currentindex) {
      return const Icon(
        Icons.circle_outlined,
        size: AppSize.s15,
      );
    } else {
      return const Icon(
        Icons.circle_rounded,
        size: AppSize.s15,
      );
    }
  }
}
