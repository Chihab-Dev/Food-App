import 'package:flutter/cupertino.dart';
import 'package:food_app/app/app_pref.dart';
import 'package:food_app/data/network/firebase_auth.dart';
import 'package:food_app/domain/usecases/user_create_usecase.dart';
import 'package:food_app/domain/usecases/user_register_usecase.dart';
import 'package:food_app/presentation/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

import '../../../app/di.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // FirebaseAuth auth = FirebaseAuth.instance;
  final AppPrefrences _appPrefrences = AppPrefrences(instance());
  final UserRegisterUsecase _userRegisterUsecase = UserRegisterUsecase(instance());
  final UserCreateUsecase _userCreateUsecase = UserCreateUsecase(instance());

  TextEditingController nameController = TextEditingController();
  bool isNameValid = false;
  String? nameError;

  void userRegister({
    required String phoneNumber,
    required String uid,
    required String fullName,
  }) async {
    emit(RegisterUpdateCurrentUserNameLoadingState());
    (await _userRegisterUsecase.start(UserRegister(fullName, phoneNumber, uid))).fold(
      (l) {
        print('🛑 RegisterUpdateCurrentUserNameErrorState');
        emit(RegisterUpdateCurrentUserNameErrorState(l.message.toString()));
      },
      (r) {
        print('✅ RegisterUpdateCurrentUserNameSuccessState');
        userCreate(fullName: fullName, phoneNumber: phoneNumber, uid: uid);
        emit(RegisterUpdateCurrentUserNameSuccessState());
      },
    );
  }

  void userCreate({
    required String fullName,
    required String phoneNumber,
    required String uid,
  }) async {
    emit(RegisterUserCreateLoadingState());

    (await _userCreateUsecase.start(UserRegister(fullName, phoneNumber, uid))).fold(
      (l) {
        print('🛑 RegisterUserCreateErrorState');
        emit(RegisterUserCreateErrorState(l.message.toString()));
      },
      (r) {
        _appPrefrences.setUserLoggedIn();
        print("  User ID $uid");
        _appPrefrences.setUserId(uid);
        emit(RegisterUserCreateSuccessState());
        print("✅ RegisterUserCreateSuccessState");
      },
    );
  }

  // void userRegister({
  //   required String phoneNumber,
  //   required String uid,
  //   required String fullName,
  // }) {
  //   emit(RegisterUpdateCurrentUserNameLoadingState());
  //   auth.currentUser!.updateDisplayName(fullName).then(
  //     (value) {
  //       emit(RegisterUpdateCurrentUserNameSuccessState());
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(RegisterUpdateCurrentUserNameErrorState(error.toString()));
  //     },
  //   );

  //   userCreate(
  //     fullName: fullName,
  //     phoneNumber: phoneNumber,
  //     uid: uid,
  //   );
  // }

  // void userCreate({
  //   required String fullName,
  //   required String phoneNumber,
  //   required String uid,
  // }) {
  //   emit(RegisterUserCreateLoadingState());
  //   CustomerResponse model = CustomerResponse(
  //     fullName,
  //     phoneNumber,
  //     uid,
  //     [],
  //   );

  //   FirebaseFirestore.instance
  //       .collection(AppStrings.users)
  //       .doc(uid)
  //       .set(
  //         model.toJson(),
  //       )
  //       .then((value) {
  //     _appPrefrences.setUserLoggedIn();
  //     print("  User ID $uid");
  //     _appPrefrences.setUserId(uid);
  //     emit(RegisterUserCreateSuccessState());
  //   }).catchError((error) {
  //     emit(RegisterUserCreateErrorState(error.toString()));
  //   });
  // }

  bool isNameValidFun(String name) {
    if (name.length >= 7 &&
        name.length <= 15 &&
        name.startsWith(" ") == false &&
        name.endsWith(" ") == false &&
        name.contains("  ") == false) {
      emit(RegisterNameValidState());
      return true;
    } else {
      emit(RegisterNameNotValidState());
      return false;
    }
  }

  String? nameErrorMessage(String name) {
    if (name.length < 7) return AppStrings.nameErrorTooShort;
    if (name.length > 15) return AppStrings.nameErrorTooLong;
    if (name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppStrings.nameErrorContainCaracters;
    }
    if (name.startsWith(" ") || name.endsWith(" ") || name.contains("  ")) {
      return AppStrings.nameErrorContainSpaces;
    } else {
      return null;
    }
  }
}
