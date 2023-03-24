import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List sliderObject = [
    "hello chihab",
    "hello ahmed",
    "hello ali",
  ];

  void goNext() {
    if (currentIndex == sliderObject.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    emit(OnBoardingGoNextState());
  }

  void goPrevious() {
    if (currentIndex == 0) {
      currentIndex = sliderObject.length - 1;
    } else {
      currentIndex--;
    }
    emit(OnBoardingGoPreviousState());
  }
}
