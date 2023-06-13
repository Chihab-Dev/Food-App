import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

import '../model/models.dart';

class AddNewMealItemUseCase extends BaseUsecase<AddNewMealObject, void> {
  final Repository _repository;

  AddNewMealItemUseCase(this._repository);
  @override
  Future<Either<Failure, void>> start(AddNewMealObject input) async {
    return await _repository.addNewMealItem(input);
  }
}
