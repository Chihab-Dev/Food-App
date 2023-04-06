import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/app/constants.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {
        if (state is BaseGetUserDataErrorState) {
          errorToast(state.error);
        }
      },
      builder: ((context, state) {
        var cubit = BaseCubit.get(context);
        CustomerObject? userData = cubit.customerObject;
        userData == null ? cubit.getUserData(userUid!, context) : null;
        return state is BaseGetUserDataLoadingState || userData == null
            ? Container(
                color: ColorManager.white,
                child: Center(
                  child: Lottie.asset(LottieAsset.loading),
                ),
              )
            : Container(
                color: ColorManager.white,
                child: Center(
                  child: Text(userData.fullName),
                ),
              );
      }),
    );
  }
}
