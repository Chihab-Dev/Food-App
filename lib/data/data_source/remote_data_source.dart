import 'package:food_app/data/network/firebase_store.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';

abstract class RemoteDataSource {
  Future<CustomerResponse> getUserData(String uid);
  Future<List<ItemResponse>> getPopularItems();
  Future<List<ItemResponse>> getItems();
  Future<void> sentOrderToFirebase(ClientAllOrders orders);
  Future<List<OrdersResponse>> getOrdersFromFirebase();
  Future<void> deleteOrder(String id);
  Future<void> addNewMealItem(AddNewMealObject addNewMealObject);
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
  Future<void> sentOrderToFirebase(ClientAllOrders orders) async {
    return await _firebaseStoreClient.sentOrderToFirebase(orders);
  }

  @override
  Future<List<OrdersResponse>> getOrdersFromFirebase() async {
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
}
