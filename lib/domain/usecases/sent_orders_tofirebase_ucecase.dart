import 'package:dartz/dartz.dart';
import 'package:food_app/domain/model/models.dart';

import '../../data/network/failure.dart';
import '../repository/repostitory.dart';
import 'base_usecase.dart';

class SentOrderToFirebaseUsecase extends BaseUsecase<ClientAllOrders, void> {
  final Repository _repository;

  SentOrderToFirebaseUsecase(this._repository);

  @override
  Future<Either<Failure, String>> start(ClientAllOrders input) async {
    return await _repository.sentOrderToFirebase(input);
  }
}
