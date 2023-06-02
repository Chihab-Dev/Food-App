import 'package:dartz/dartz.dart';
import 'package:food_app/domain/model/models.dart';

import '../../data/network/failure.dart';
import '../repository/repostitory.dart';
import 'base_usecase.dart';

class SentOrderToFirebaseUsecase extends BaseUsecase<Orders, void> {
  final Repository _repository;

  SentOrderToFirebaseUsecase(this._repository);

  @override
  Future<Either<Failure, void>> start(Orders orders) async {
    return await _repository.sentOrderToFirebase(orders);
  }
}
