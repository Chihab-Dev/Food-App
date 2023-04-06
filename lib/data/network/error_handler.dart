// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:food_app/data/network/failure.dart';

import '../../presentation/resources/strings_manager.dart';

enum DataSource {
  SUCCESS,
  FIREBASE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.FIREBASE_ERROR:
        return Failure(ResponseCode.FIREBASE_ERROR, ResponseMessage.FIREBASE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const String SUCCESS = "0";
  static const String FIREBASE_ERROR = "1";
  static const String NO_INTERNET_CONNECTION = "0";
  static const String DEFAULT = "0";
}

class ResponseMessage {
  static String SUCCESS = AppStrings.sucess;
  static const String FIREBASE_ERROR = AppStrings.firebaseError;
  static String NO_INTERNET_CONNECTION = AppStrings.noInternetConnection;
  static String DEFAULT = AppStrings.defaultMsg;
}
