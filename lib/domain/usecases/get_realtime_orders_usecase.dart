import 'package:food_app/domain/model/models.dart';
import 'package:food_app/domain/repository/repostitory.dart';

class GetRealtimeOrdersUsecase {
  final Repository _repository;

  GetRealtimeOrdersUsecase(this._repository);

  Stream<List<ClientAllOrders>> start() {
    return _repository.getRealtimeOrders();
  }
}
