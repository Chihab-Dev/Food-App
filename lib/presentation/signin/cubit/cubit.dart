import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app/di.dart';
import 'package:food_app/data/network/firebase_auth.dart';
import 'package:food_app/domain/usecases/verify_phone_number_usecase.dart';
import 'package:food_app/presentation/signin/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

import '../../resources/widgets.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninInittialState());

  static SigninCubit get(context) => BlocProvider.of(context);

  VerifyPhoneNumberUsecase verifyPhoneNumberUsecase = VerifyPhoneNumberUsecase(instance());

  TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;
  String? phoneError;

  void verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    emit(SigninVerifyPhoneNumberLoadingState());
    (await verifyPhoneNumberUsecase.start(VerifyPhoneNumberModel(
      '+213$phoneNumber',
      (PhoneAuthCredential credential) async {
        // print("✅ verification Completed ${credential.verificationId}");
        // await auth.signInWithCredential(credential);
        // if (auth.currentUser != null) {
        //   Navigator.pushReplacementNamed(context, Routes.main);
        // }
      },
      (FirebaseAuthException e) {
        emit(SigninVerifyPhoneNumberErrorState());
        print("🛑 verification Failed ${e.code}  ${e.message}");
        errorToast(e.message ?? AppStrings.verificationFailed).show(context);
      },
      (String verificationId, int? resendToken) {
        emit(SigninVerifyPhoneNumberSuccessState());
        Navigator.pushNamed(context, Routes.otp, arguments: verificationId);
      },
      (String verificationId) {},
      const Duration(seconds: 60),
    )))
        .fold(
      (failure) {
        emit(SigninVerifyPhoneNumberErrorState());
        errorToast(failure.message.toString()).show(context);
        print("🔥 verifyPhoneNumber error : ${failure.message}");
      },
      (data) {},
    );
  }

  bool isPhoneNumberValid(String phoneNumber, BuildContext context) {
    if (phoneNumber.length == 10 &&
        int.tryParse(phoneNumber) != null &&
        (phoneNumber.substring(0, 2) == "06" ||
            phoneNumber.substring(0, 2) == "05" ||
            phoneNumber.substring(0, 2) == "07")) {
      emit(SigninIsNumberValidState());
      return true;
    } else {
      emit(SigninIsNumberNotValidState());
      return false;
    }
  }

  String? phoneErrorMessage(String phoneNumber) {
    // if ((phoneNumber.substring(0, 2) != "06" &&
    //     phoneNumber.substring(0, 2) != "05" &&
    //     phoneNumber.substring(0, 2) != "07")) {
    //   return "Phone Number must begin with 05 06 07";
    // }

    if (int.tryParse(phoneNumber) == null) return "Phone Number mustn't contains caracters";

    if (phoneNumber.length != 10) {
      return "Phone Number must be 10 numbers";
    } else {
      return null;
    }
  }
}
