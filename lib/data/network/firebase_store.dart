import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    return await _firestore
        .collection("items")
        .orderBy("stars", descending: true // Sort in descending order
            )
        .limit(5)
        .get()
        .then(
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

  Future<void> sentOrderToFirebase(ClientAllOrders orders) async {
    return await _firestore
        .collection(AppStrings.orders)
        .add(
          orders.toMap(),
        )
        .then((value) {
      value.update(
        {'orderId': value.id},
      );
    }).catchError((error) {
      print(error.toString());
    });
  }

// return await _firestore
//         .collection("orders")
//         .add(orders.toJson()).
//         .then((value) {
//       print(" ✅ Sent Order To Firebase Success");
//     }).catchError((error) {
//       print(" 🛑 Sent Order To Firebase error");
//       print(error.toString());
//     });
//   }}

  Future<List<OrdersResponse>> getOrdersFromFirebase() async {
    return await _firestore.collection(AppStrings.orders).orderBy("date").get().then(
      (value) {
        List<OrdersResponse> orders = [];
        for (var element in value.docs) {
          orders.add(OrdersResponse.fromJson(element.data()));
        }
        return orders;
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<void> deleteOrder(String id) async {
    return await _firestore.collection(AppStrings.orders).doc(id).delete().then(
      (value) {
        print('Item deleted successfully!');
      },
    ).catchError(
      (error) {
        print('Failed to delete item: $error');
      },
    );
  }

  Future<void> addNewMealItem(AddNewMealObject addNewMealObject) async {
    String imageUrl = await uploadImageAndGetUrl(addNewMealObject.file!);

    Map<String, dynamic> itemData = addNewMealObject.itemObject.toMap();
    itemData['image'] = imageUrl;

    return await _firestore.collection(AppStrings.items).add(itemData).then(
      (value) {
        value.update(
          {'id': value.id},
        );
      },
    ).catchError(
      (error) {},
    );
  }

  Future<String> uploadImageAndGetUrl(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
