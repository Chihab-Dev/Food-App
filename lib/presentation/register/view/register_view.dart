import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/presentation/register/cubit/cubit.dart';
import 'package:food_app/presentation/register/cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';

import '../../resources/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.phoneNumber, required this.uid});

  final String phoneNumber;
  final String uid;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterUserCreateSuccessState) {
            Navigator.pushReplacementNamed(context, Routes.main);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: ColorManager.orange),
                elevation: 0,
              ),
              body: Container(
                color: ColorManager.whiteGrey,
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p14.sp),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(LottieAsset.login),
                          SizedBox(height: AppSize.s50.sp),
                          customFormField(
                            context,
                            (value) {
                              cubit.isNameValid = cubit.isNameValidFun(value);
                              cubit.nameError = cubit.nameErrorMessage(value);
                            },
                            Icons.person,
                            TextInputType.name,
                            cubit.nameController,
                            cubit.nameError,
                            label: AppStrings.fullName,
                          ),
                           SizedBox(height: AppSize.s25.sp),
                          state is RegisterUpdateCurrentUserNameLoadingState
                              ? CircularProgressIndicator(color: ColorManager.orange)
                              : SizedBox(
                                  height: AppSize.s50.sp,
                                  width: AppSize.s300.sp,
                                  child: ElevatedButton(
                                    onPressed: cubit.isNameValid
                                        ? () {
                                            cubit.userRegister(
                                                phoneNumber: widget.phoneNumber,
                                                uid: widget.uid,
                                                fullName: cubit.nameController.text);
                                          }
                                        : null,
                                    child: Text(
                                      AppStrings.register,
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
