import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/signin/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

import '../../resources/widgets.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninInittialState());

  static SigninCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;
  String? phoneError;

  void verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      emit(SigninVerifyPhoneNumberLoadingState());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+213$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // print("✅ verification Completed ${credential.verificationId}");
          // await auth.signInWithCredential(credential);
          // if (auth.currentUser != null) {
          //   Navigator.pushReplacementNamed(context, Routes.main);
          // }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(SigninVerifyPhoneNumberErrorState());
          print("🛑 verification Failed ${e.code}  ${e.message}");
          errorToast(e.message ?? AppStrings.verificationFailed).show(context);
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(SigninVerifyPhoneNumberSuccessState());
          Navigator.pushNamed(context, Routes.otp, arguments: verificationId);
        },

        timeout: const Duration(seconds: 60),
        // ki y5las timeOut li 7tito (ex: 10s) t5fm function hadi
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(SigninVerifyPhoneNumberErrorState());
      errorToast(e.toString()).show(context);
      print("🔥 verifyPhoneNumber error : $e");
    }
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
