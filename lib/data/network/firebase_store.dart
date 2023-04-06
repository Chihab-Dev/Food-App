import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

class FirebaseStoreClient {
  final FirebaseFirestore _firestore;

  FirebaseStoreClient(this._firestore);

  Future<CustomerResponse> getUserData(String uid) async {
    return _firestore.collection(AppStrings.users).doc(uid).get().then(
      (value) {
        return CustomerResponse.fromJson(value.data()!);
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }
}
