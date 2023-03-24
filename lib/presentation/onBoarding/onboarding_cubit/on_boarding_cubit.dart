import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/onBoarding/onboarding_cubit/on_boarding_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<SliderObject> sliderObject = [
    SliderObject(
      ImageAsset.pizzaImage,
      "Pizza",
      "Fresh pizza from our restaurent yahooooooooo yammy",
    ),
    SliderObject(
      ImageAsset.burgerImage,
      "burger",
      "Fresh burger from our restaurent yahooooooooo yammy",
    ),
    SliderObject(
      ImageAsset.hotdogImage,
      "hotdog",
      "Fresh hotdog from our restaurent yahooooooooo yammy",
    ),
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
