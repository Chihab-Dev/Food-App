// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

import '../../data/network/firebase_auth.dart';

class OtpCheckUsecase extends BaseUsecase<OtpCheckUsecaseParam, OtpCheckModel> {
  final Repository _repository;

  OtpCheckUsecase(this._repository);
  @override
  Future<Either<Failure, OtpCheckModel>> start(OtpCheckUsecaseParam input) {
    return _repository.otpCheck(input.verificationId, input.smsCode);
  }
}

class OtpCheckUsecaseParam {
  String verificationId;
  String smsCode;
  OtpCheckUsecaseParam(this.verificationId, this.smsCode);
}
