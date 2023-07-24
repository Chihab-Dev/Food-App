import 'package:dartz/dartz.dart';
import 'package:food_app/data/network/failure.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:http/http.dart';

import '../../data/network/firebase_auth.dart';

abstract class Repository {
  Future<Either<Failure, OtpCheckModel>> otpCheck(String verificationId, String smsCode);
  Future<Either<Failure, CustomerObject>> getUserData(String uid);
  Future<Either<Failure, List<ItemObject>>> getPopularItems();
  Future<Either<Failure, List<ItemObject>>> getItems();
  Future<Either<Failure, String>> sentOrderToFirebase(ClientAllOrders orders);
  Future<Either<Failure, List<ClientAllOrders>>> getOrdersFromFirebase();
  Future<Either<Failure, void>> deleteOrder(String id);
  Future<Either<Failure, void>> addNewMealItem(AddNewMealObject addNewMealObject);
  Future<Either<Failure, void>> deleteMeal(String id);
  Stream<String> getRealTimeOrderState(String id);
  Future<Either<Failure, void>> changingOrderState(ChangingOrderStateObject object);
  Stream<List<ClientAllOrders>> getRealtimeOrders();
  Future<Either<Failure, void>> addItemToFavoriteList(AddToFavoriteObject addToFavoriteObject);
  Future<Either<Failure, void>> removeItemFromFavoriteList(AddToFavoriteObject addToFavoriteObject);
  Future<Either<Failure, bool>> getIsStoreOpen();
  Future<Either<Failure, void>> changeIsStoreOpen();
  Future<Either<Failure, void>> saveToken(String token);
  Future<Either<Failure, Response>> sentPushNotification(String token, String notificationBody);
}
