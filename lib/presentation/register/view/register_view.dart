import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController nameController = TextEditingController();
  bool isNameValid = false;
  String? nameError;

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
                  padding: const EdgeInsets.all(AppPadding.p14),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(LottieAsset.login),
                          const SizedBox(height: AppSize.s50),
                          customFormField(
                            context,
                            (value) {
                              isNameValid = cubit.isNameValid(value);
                              nameError = cubit.nameErrorMessage(value);
                            },
                            Icons.person,
                            TextInputType.name,
                            nameController,
                            nameError,
                            label: AppStrings.fullName,
                          ),
                          const SizedBox(height: AppSize.s25),
                          state is RegisterUpdateCurrentUserNameLoadingState
                              ? CircularProgressIndicator(color: ColorManager.orange)
                              : SizedBox(
                                  height: AppSize.s50,
                                  width: AppSize.s300,
                                  child: ElevatedButton(
                                    onPressed: isNameValid
                                        ? () {
                                            cubit.userRegister(
                                                phoneNumber: widget.phoneNumber,
                                                uid: widget.uid,
                                                fullName: nameController.text);
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
