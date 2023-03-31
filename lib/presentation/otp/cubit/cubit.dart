import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/otp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../resources/routes_manager.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInittialState());

  static OtpCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;

  void otpCheck({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    emit(OtpCheckLoadingState());
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      var credentials = await auth.signInWithCredential(credential);

      print("🛑🛑🛑 user uid${credentials.user!.uid}");

      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(credentials.user!.uid).get();

      if (snapshot.exists == false) {
        print("🛑🛑🛑 New user");
        emit(OtpNewUserState());
        Navigator.pushNamed(
          context,
          Routes.register,
          arguments: RegisterViewParamters(
            credentials.user!.phoneNumber!,
            credentials.user!.uid,
          ),
        );
      } else {
        print("🛑🛑🛑 old User");
        emit(OtpOldUserState());
        Navigator.pushReplacementNamed(context, Routes.main);
      }
    } on FirebaseAuthException catch (e) {
      emit(OtpCheckErrorState());
      print("🛑 Otp Code failed : ${e.message}");
      errorToast(
        e.message == AppStrings.smsCodeError
            ? AppStrings.smsCodeNotValidMessage
            : e.message ?? AppStrings.smsCodeNotValidMessage,
      ).show(context);
    }
  }

  // functions ::

  bool isSmsCodeValid(String smsCode) {
    if (smsCode.length == 6) {
      emit(OtpSmsCodeValidState());
      return true;
    } else {
      emit(OtpSmsCodeValidState());
      return false;
    }
  }
}
