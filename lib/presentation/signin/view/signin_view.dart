import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/presentation/signin/cubit/cubit.dart';
import 'package:food_app/presentation/signin/cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';

import '../../resources/widgets.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: BlocConsumer<SigninCubit, SigninStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SigninCubit.get(context);
          return Scaffold(
              body: Container(
            color: ColorManager.whiteGrey,
            height: double.infinity,
            child: Padding(
              padding:  EdgeInsets.all(AppPadding.p14.sp),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(LottieAsset.phoneNumber),
                      SizedBox(height: AppSize.s25.sp),
                      customFormField(
                        context,
                        (value) {
                          cubit.isPhoneValid = cubit.isPhoneNumberValid(value, context);
                          cubit.phoneError = cubit.phoneErrorMessage(value);
                        },
                        Icons.phone,
                        TextInputType.phone,
                        cubit.phoneController,
                        cubit.phoneError,
                        label: AppStrings.phoneNumber,
                      ),
                      SizedBox(height: AppSize.s25.sp),
                      state is SigninVerifyPhoneNumberLoadingState
                          ? CircularProgressIndicator(color: ColorManager.orange)
                          : SizedBox(
                              height: AppSize.s50.sp,
                              width: AppSize.s300.sp,
                              child: ElevatedButton(
                                onPressed: cubit.isPhoneValid
                                    ? () {
                                        cubit.verifyPhoneNumber(context, cubit.phoneController.text);
                                      }
                                    : null,
                                child: Text(
                                  AppStrings.login,
                                  style: TextStyle(color: ColorManager.white),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
