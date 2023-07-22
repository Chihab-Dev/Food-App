// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';
import 'package:http/http.dart';

class SentPushNotificationUsecase extends BaseUsecase<NotifUsecaseParameters, Response> {
  final Repository _repository;

  SentPushNotificationUsecase(this._repository);
  @override
  Future<Either<Failure, Response>> start(NotifUsecaseParameters param) async {
    return _repository.sentPushNotification(param.token, param.notificationBody);
  }
}

class NotifUsecaseParameters {
  String token;
  String notificationBody;

  NotifUsecaseParameters(this.token, this.notificationBody);
}
