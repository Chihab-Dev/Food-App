import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;
  String? phoneError;

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
            color: ColorManager.white,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(LottieAsset.phoneNumber),
                      const SizedBox(height: AppSize.s25),
                      customFormField(
                        context,
                        (value) {
                          isPhoneValid = cubit.isPhoneNumberValid(value, context);
                          phoneError = cubit.phoneErrorMessage(value);
                        },
                        Icons.phone,
                        TextInputType.phone,
                        phoneController,
                        phoneError,
                        label: AppStrings.phoneNumber,
                      ),
                      const SizedBox(height: AppSize.s25),
                      state is SigninVerifyPhoneNumberLoadingState
                          ? CircularProgressIndicator(color: ColorManager.orange)
                          : SizedBox(
                              height: AppSize.s50,
                              width: AppSize.s300,
                              child: ElevatedButton(
                                onPressed: isPhoneValid
                                    ? () {
                                        cubit.verifyPhoneNumber(context, phoneController.text);
                                      }
                                    : null,
                                child: const Text(AppStrings.login),
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
