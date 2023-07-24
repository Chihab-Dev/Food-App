import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/data/network/firebase_auth.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class VerifyPhoneNumberUsecase extends BaseUsecase<VerifyPhoneNumberModel, void> {
  final Repository _repository;

  VerifyPhoneNumberUsecase(this._repository);
  @override
  Future<Either<Failure, void>> start(VerifyPhoneNumberModel input) async {
    return await _repository.verifyPhoneNumber(input);
  }
}
