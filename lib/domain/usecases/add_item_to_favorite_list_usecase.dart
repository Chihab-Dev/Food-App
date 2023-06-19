import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class AddItemToFavoriteListUsecase extends BaseUsecase<AddToFavoriteObject, void> {
  final Repository _repository;

  AddItemToFavoriteListUsecase(this._repository);
  @override
  Future<Either<Failure, void>> start(AddToFavoriteObject input) async {
    return await _repository.addItemToFavoriteList(input);
  }
}
