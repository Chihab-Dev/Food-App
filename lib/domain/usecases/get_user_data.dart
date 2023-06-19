// ignore_for_file: avoid_renaming_method_parameters

import 'package:food_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class GetUserDataUsecase extends BaseUsecase<String, CustomerObject> {
  final Repository _repository;

  GetUserDataUsecase(this._repository);
  @override
  Future<Either<Failure, CustomerObject>> start(String uid) async {
    return await _repository.getUserData(uid);
  }
}
