import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';

class FirebaseStoreClient {
  final FirebaseFirestore _firestore;

  FirebaseStoreClient(this._firestore);

  Future<CustomerResponse> getUserData(String uid) async {
    return await _firestore.collection(AppStrings.users).doc(uid).get().then(
      (value) {
        return CustomerResponse.fromJson(value.data()!);
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<List<ItemResponse>> getPopularItems() async {
    return await _firestore.collection("items").orderBy("stars").get().then(
      (value) {
        List<ItemResponse> popularItems = [];
        for (var element in value.docs) {
          popularItems.add(ItemResponse.fromJson(element.data()));
        }
        return popularItems;
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<List<ItemResponse>> getItems() async {
    return await _firestore.collection("items").get().then(
      (value) {
        List<ItemResponse> items = [];
        for (var element in value.docs) {
          items.add(ItemResponse.fromJson(element.data()));
          print(element.data());
        }
        return items;
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }
}
