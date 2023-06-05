import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/repository/repostitory.dart';
import 'package:food_app/domain/usecases/base_usecase.dart';

class GetOrdersFromFirebaseUseCase extends BaseUsecase<void, List<ClientAllOrders>> {
  final Repository _repository;

  GetOrdersFromFirebaseUseCase(this._repository);
  @override
  Future<Either<Failure, List<ClientAllOrders>>> start(void input) async {
    return await _repository.getOrdersFromFirebase();
  }
}
