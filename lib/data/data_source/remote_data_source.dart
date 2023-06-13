import 'package:food_app/data/network/firebase_store.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';

abstract class RemoteDataSource {
  Future<CustomerResponse> getUserData(String uid);
  Future<List<ItemResponse>> getPopularItems();
  Future<List<ItemResponse>> getItems();
  Future<String> sentOrderToFirebase(ClientAllOrders orders);
  Future<List<ClientAllOrdersResponse>> getOrdersFromFirebase();
  Future<void> deleteOrder(String id);
  Future<void> addNewMealItem(AddNewMealObject addNewMealObject);
  Future<void> deleteMeal(String id);
  Stream<String> getRealTimeOrderState(String id);
  Future<void> changingOrderState(ChangingOrderStateObject object);
  Stream<List<ClientAllOrdersResponse>> getRealtimeOrders();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseStoreClient _firebaseStoreClient;
  RemoteDataSourceImpl(this._firebaseStoreClient);

  @override
  Future<CustomerResponse> getUserData(String uid) async {
    return await _firebaseStoreClient.getUserData(uid);
  }

  @override
  Future<List<ItemResponse>> getPopularItems() async {
    return await _firebaseStoreClient.getPopularItems();
  }

  @override
  Future<List<ItemResponse>> getItems() async {
    return await _firebaseStoreClient.getItems();
  }

  @override
  Future<String> sentOrderToFirebase(ClientAllOrders orders) async {
    return await _firebaseStoreClient.sentOrderToFirebase(orders);
  }

  @override
  Future<List<ClientAllOrdersResponse>> getOrdersFromFirebase() async {
    return await _firebaseStoreClient.getOrdersFromFirebase();
  }

  @override
  Future<void> deleteOrder(String id) async {
    return await _firebaseStoreClient.deleteOrder(id);
  }

  @override
  Future<void> addNewMealItem(AddNewMealObject addNewMealObject) async {
    return await _firebaseStoreClient.addNewMealItem(addNewMealObject);
  }

  @override
  Future<void> deleteMeal(String id) async {
    await _firebaseStoreClient.deleteMeal(id);
  }

  @override
  Stream<String> getRealTimeOrderState(String id) {
    return _firebaseStoreClient.getRealTimeOrderState(id);
  }

  @override
  Future<void> changingOrderState(ChangingOrderStateObject object) async {
    return await _firebaseStoreClient.changingOrderState(object);
  }

  @override
  Stream<List<ClientAllOrdersResponse>> getRealtimeOrders() {
    return _firebaseStoreClient.getRealtimeOrders();
  }
}
