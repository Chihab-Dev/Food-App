import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class ChangingOrderStateUsecase extends BaseUsecase<ChangingOrderStateObject, void> {
  final Repository _repository;
  ChangingOrderStateUsecase(this._repository);

  @override
  Future<Either<Failure, void>> start(ChangingOrderStateObject input) async {
    return await _repository.changingOrderState(input);
  }
}
