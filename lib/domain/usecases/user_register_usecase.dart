import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/data/network/firebase_auth.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class UserRegisterUsecase extends BaseUsecase<UserRegister, void> {
  final Repository _repository;

  UserRegisterUsecase(this._repository);
  @override
  Future<Either<Failure, void>> start(UserRegister input) async {
    return await _repository.userRegister(input);
  }
}
