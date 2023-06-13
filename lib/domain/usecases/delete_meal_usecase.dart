import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class DeleteMealUsecase extends BaseUsecase<String, void> {
  final Repository _repository;

  DeleteMealUsecase(this._repository);

  @override
  Future<Either<Failure, void>> start(String input) async {
    return await _repository.deleteMeal(input);
  }
}
