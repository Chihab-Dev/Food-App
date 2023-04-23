import 'package:food_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

import '../repository/repostitory.dart';

class GetPopularItemsUsecase extends BaseUsecase<void, List<ItemObject>> {
  final Repository _repository;

  GetPopularItemsUsecase(this._repository);
  @override
  Future<Either<Failure, List<ItemObject>>> start(void input) async {
    return await _repository.getPopularItems();
  }
}
