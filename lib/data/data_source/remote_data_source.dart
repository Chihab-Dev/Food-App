import 'package:food_app/data/network/firebase_store.dart';
import 'package:food_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<CustomerResponse> getUserData(String uid);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseStoreClient _firebaseStoreClient;
  RemoteDataSourceImpl(this._firebaseStoreClient);

  @override
  Future<CustomerResponse> getUserData(String uid) async {
    return _firebaseStoreClient.getUserData(uid);
  }
}
