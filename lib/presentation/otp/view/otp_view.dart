import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/presentation/otp/cubit/cubit.dart';
import 'package:food_app/presentation/otp/cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpView extends StatefulWidget {
  const OtpView({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;

    return BlocProvider(
      create: (context) => OtpCubit(),
      child: BlocConsumer<OtpCubit, OtpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = OtpCubit.get(context);
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
                  padding: EdgeInsets.all(AppPadding.p14.sp).copyWith(top: 0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(LottieAsset.otpAnimation),
                          SizedBox(height: AppSize.s50.sp),
                          SizedBox(
                            width: AppSize.s300.sp,
                            child: PinCodeTextField(
                              controller: cubit.codeController,
                              appContext: context,
                              autoDismissKeyboard: true,
                              cursorColor: ColorManager.orange,
                              length: 6,
                              onChanged: (e) {
                                cubit.isSmsCodeValid = cubit.isSmsCodeValidFun(e);
                              },
                            ),
                          ),
                          // const SizedBox(height: AppSize.s50),
                          // SizedBox(
                          //   height: AppSize.s60,
                          //   width: AppSize.s300,
                          //   child: TextFormField(
                          //     controller: codeController,
                          //     style: TextStyle(
                          //       color: ColorManager.orange,
                          //     ),
                          //     keyboardType: TextInputType.phone,
                          //     decoration: InputDecoration(
                          //       prefixIcon: Icon(Icons.key, color: ColorManager.orange),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: AppSize.s50.sp),
                          state is OtpCheckLoadingState
                              ? CircularProgressIndicator(color: ColorManager.orange)
                              : SizedBox(
                                  height: AppSize.s50.sp,
                                  width: AppSize.s300.sp,
                                  child: ElevatedButton(
                                    onPressed: cubit.isSmsCodeValid == true
                                        ? () {
                                            cubit.otpCheck(
                                              context: context,
                                              verificationId: widget.verificationId,
                                              smsCode: cubit.codeController.text,
                                            );
                                          }
                                        : null,
                                    child: Text(
                                      AppStrings.otpVerify,
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
