// ignore_for_file: constant_identifier_names

import 'dart:io';

class CustomerObject {
  String fullName;
  String phoneNumber;
  String uid;

  CustomerObject(this.fullName, this.phoneNumber, this.uid);
}

enum ItemCategory {
  FASTFOOD,
  DRINK,
  SNACK,
  DESSERT,
  PIZZA,
  BURGER,
  HOTDOG,
}

class ItemObject {
  String id;
  String image;
  String title;
  String description;
  int price;
  int stars;
  ItemCategory category;
  int calories;
  int preparationTime;

  ItemObject(
    this.id,
    this.image,
    this.title,
    this.description,
    this.price,
    this.stars,
    this.category,
    this.calories,
    this.preparationTime,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'stars': stars,
      'category': category.toString().split('.').last,
      'calories': calories,
      "preparationTime": preparationTime,
    };
  }
}

class Order {
  ItemObject itemObject;
  int quentity;

  Order(this.itemObject, this.quentity);
}

enum OrderState {
  WAITING,
  PREPARING,
  DELIVERING,
  FINISHED,
}

class ClientAllOrders {
  late List<Order> orders;
  late String phoneNumber;
  late String location;
  late String orderId;
  late String date;
  OrderState state;

  ClientAllOrders(
    this.orders,
    this.phoneNumber,
    this.location,
    this.orderId,
    this.date,
    this.state,
  );

  Map<String, dynamic> toMap() {
    return {
      'orders': orders
          .map(
            (order) => {
              'itemObject': {
                'image': order.itemObject.image,
                'title': order.itemObject.title,
                'description': order.itemObject.description,
                'price': order.itemObject.price,
                'stars': order.itemObject.stars,
              },
              'quentity': order.quentity,
            },
          )
          .toList(),
      'phoneNumber': phoneNumber,
      'location': location,
      'orderId': orderId,
      'date': date,
      'state': state.toString().split('.').last,
    };
  }
}

// Orders.fromJson(Map<String, dynamic> json) {
//   var orderslist = json["orders"] as List;
//   List<Order> orders = orderslist.map(
//     (orderJson) {
//       var itemObjectJson = orderJson["itemObject"];
//       var itemObject = ItemObject(
//         itemObjectJson["image"],
//         itemObjectJson["title"],
//         itemObjectJson["description"],
//         itemObjectJson["price"],
//         itemObjectJson["stars"],
//       );
//       var quentity = orderJson["quentity"];

//       return Order(itemObject, quentity);
//     },
//   ).toList();
//   this.orders = orders;
//   phoneNumber = json['phoneNumber'];
//   location = json['location'];
//   orderId = json['orderId'];
// }

// parameteres ::
class AddNewMealObject {
  ItemObject itemObject;
  File? file;

  AddNewMealObject(this.itemObject, this.file);
}

class ChangingOrderStateObject {
  String orderId;
  OrderState orderState;

  ChangingOrderStateObject(this.orderId, this.orderState);
}
