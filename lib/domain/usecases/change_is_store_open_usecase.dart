import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class ChangeIsStoreOpenUsecase extends BaseUsecase<void, void> {
  final Repository _repository;

  ChangeIsStoreOpenUsecase(this._repository);

  @override
  Future<Either<Failure, void>> start(void input) async {
    return await _repository.changeIsStoreOpen();
  }
}
