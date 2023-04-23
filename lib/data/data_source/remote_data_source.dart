import 'package:food_app/data/network/firebase_store.dart';
import 'package:food_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<CustomerResponse> getUserData(String uid);
  Future<List<ItemResponse>> getPopularItems();
  Future<List<ItemResponse>> getItems();
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
}
