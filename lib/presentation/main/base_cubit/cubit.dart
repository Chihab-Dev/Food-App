import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/usecases/get_home_data.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';

import '../../../app/app_pref.dart';
import '../../../app/di.dart';

class BaseCubit extends Cubit<BaseStates> {
  BaseCubit() : super(BaseInitialState());

  static BaseCubit get(context) => BlocProvider.of(context);

  final GetUserDataUsecase _getUserDataUsecase = GetUserDataUsecase(instance());
  final AppPrefrences _appPrefrences = AppPrefrences(instance());

  CustomerObject? customerObject;

  Future<String> getUserId() async {
    return await _appPrefrences.getUserId();
  }

  void getUserData(String uid, BuildContext context) async {
    emit(BaseGetUserDataLoadingState());
    (await _getUserDataUsecase.start(await getUserId())).fold(
      (failure) {
        emit(BaseGetUserDataErrorState(failure.message));
      },
      (customerObjectData) {
        emit(BaseGetUserDataSucessState());
        customerObject = customerObjectData;
      },
    );
    return null;
  }
}
