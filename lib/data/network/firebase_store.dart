import 'dart:async';
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
        .limit(3)
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
        }
        return items;
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }

  Future<String> sentOrderToFirebase(ClientAllOrders orders) async {
    return await _firestore
        .collection(AppStrings.orders)
        .add(
          orders.toMap(),
        )
        .then((value) {
      print('✅✅✅');
      value.update(
        {'orderId': value.id},
      );
      return value.id;
    }).catchError((error) {
      print('🛑🛑🛑');
      print(error.toString());
      throw error;
    });
  }

  Stream<String> getRealTimeOrderState(String orderId) {
    return FirebaseFirestore.instance.collection(AppStrings.orders).doc(orderId).snapshots().map(
      (snapshot) {
        return snapshot['state'];
      },
    );
  }

  Future<void> changingOrderState(ChangingOrderStateObject object) {
    Map<String, dynamic> data = {
      'state': object.orderState.toString().split('.').last,
    };

    return _firestore.collection(AppStrings.orders).doc(object.orderId).update(data).then(
      (value) {
        print("Order state updated successfully");
      },
    ).catchError(
      (error) {
        print("Error updating order state: \n$error");
      },
    );
  }

  Future<List<ClientAllOrdersResponse>> getOrdersFromFirebase() async {
    return await _firestore.collection(AppStrings.orders).orderBy("date").get().then(
      (value) {
        List<ClientAllOrdersResponse> orders = [];
        for (var element in value.docs) {
          orders.add(ClientAllOrdersResponse.fromJson(element.data()));
        }
        return orders;
      },
    ).catchError(
      (error) {
        throw error;
      },
    );
  }

  Stream<List<ClientAllOrdersResponse>> getRealtimeOrders() {
    return _firestore.collection(AppStrings.orders).orderBy('date').snapshots().map(
      (querySnapshot) {
        List<ClientAllOrdersResponse> list = [];

        // Mapping query snapshot: The snapshots() method returns a stream of
        // QuerySnapshot objects. We need to iterate over the docs property of the snapshot
        // and convert each document to the ClientAllOrdersResponse model object
        for (var element in querySnapshot.docs) {
          ClientAllOrdersResponse order = ClientAllOrdersResponse.fromJson(element.data());
          list.add(order);
        }

        return list;
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
        throw error;
      },
    );
  }

  Future<void> addNewMealItem(AddNewMealObject addNewMealObject) async {
    String imageUrl = await uploadImageAndGetUrl(addNewMealObject.file!);

    Map<String, dynamic> itemData = addNewMealObject.itemObject.toMap();
    itemData['image'] = imageUrl;

    return await _firestore.collection(AppStrings.items).add(itemData).then(
      (value) {
        print("✅✅✅");
        value.update(
          {'id': value.id},
        );
      },
    ).catchError(
      (error) {
        print("🛑🛑🛑");
        throw error;
      },
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

  Future<void> deleteMeal(String id) async {
    await _firestore.collection(AppStrings.items).doc(id).delete().then(
      (value) {
        print("Meal Deleted Success");
      },
    ).catchError(
      (error) {
        print("Meal Delete error");
        throw error;
      },
    );
  }
}
