import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';

abstract class Repository {
  Future<Either<Failure, CustomerObject>> getUserData(String uid);
  Future<Either<Failure, List<ItemObject>>> getPopularItems();
  Future<Either<Failure, List<ItemObject>>> getItems();
  Future<Either<Failure, void>> sentOrderToFirebase(ClientAllOrders orders);
  Future<Either<Failure, List<ClientAllOrders>>> getOrdersFromFirebase();
  Future<Either<Failure, void>> deleteOrder(String id);
  Future<Either<Failure, void>> addNewMealItem(AddNewMealObject addNewMealObject);
}
