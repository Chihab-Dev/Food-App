import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_cubit.dart';
import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_states.dart';

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
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.goPrevious();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Text(cubit.sliderObject[cubit.currentIndex]),
                  IconButton(
                    onPressed: () {
                      cubit.goNext();
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
