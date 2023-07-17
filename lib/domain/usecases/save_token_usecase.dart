import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class SaveTokenUsecase extends BaseUsecase<String, void> {
  final Repository _repository;

  SaveTokenUsecase(this._repository);
  @override
  Future<Either<Failure, void>> start(String input) {
    return _repository.saveToken(input);
  }
}
