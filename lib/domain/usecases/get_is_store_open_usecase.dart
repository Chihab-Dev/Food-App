import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class GetIsStoreOpenUsecase extends BaseUsecase<void, bool> {
  final Repository _repository;

  GetIsStoreOpenUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> start(void input) async {
    return await _repository.getIsStoreOpen();
  }
}
