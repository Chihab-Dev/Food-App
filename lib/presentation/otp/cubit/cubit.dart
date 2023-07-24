import 'package:flutter/material.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/domain/usecases/otp_check_usecase.dart';
import 'package:food_app/presentation/otp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../resources/routes_manager.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInittialState());

  static OtpCubit get(context) => BlocProvider.of(context);

  final AppPrefrences _appPrefrences = AppPrefrences(instance());

  final OtpCheckUsecase _otpCheckUsecase = OtpCheckUsecase(instance());

  TextEditingController codeController = TextEditingController();
  bool isSmsCodeValid = false;

  void otpCheck({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    emit(OtpCheckLoadingState());
    (await _otpCheckUsecase.start(OtpCheckUsecaseParam(verificationId, smsCode))).fold(
      (failure) {
        print("🛑 Otp Code failed : ${failure.message}");
        emit(OtpCheckErrorState());
        errorToast(
          failure.message == AppStrings.smsCodeError ? AppStrings.smsCodeNotValidMessage : failure.message,
        ).show(context);
      },
      (data) {
        if (data.documentSnapshot.exists == false) {
          print("🛑🛑🛑 New user");
          emit(OtpNewUserState());
          Navigator.pushNamed(
            context,
            Routes.register,
            arguments: RegisterViewParamters(
              data.credentials.user!.phoneNumber!,
              data.credentials.user!.uid,
            ),
          );
        } else {
          print("🛑🛑🛑 old User ${data.credentials.user!.uid}");
          emit(OtpOldUserState());
          _appPrefrences.setUserLoggedIn();
          _appPrefrences.setUserId(data.credentials.user!.uid);
          Navigator.pushReplacementNamed(context, Routes.main);
        }
      },
    );
  }

  // functions ::

  bool isSmsCodeValidFun(String smsCode) {
    if (smsCode.length == 6) {
      emit(OtpSmsCodeValidState());
      return true;
    } else {
      emit(OtpSmsCodeValidState());
      return false;
    }
  }
}
