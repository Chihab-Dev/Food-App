class CustomerObject {
  String fullName;
  String phoneNumber;
  String uid;

  CustomerObject(this.fullName, this.phoneNumber, this.uid);
}

class ItemObject {
  String id;
  String image;
  String title;
  String description;
  int price;
  int stars;

  ItemObject(
    this.id,
    this.image,
    this.title,
    this.description,
    this.price,
    this.stars,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'stars': stars,
    };
  }
}

class Order {
  ItemObject itemObject;
  int quentity;

  Order(this.itemObject, this.quentity);
}

class ClientAllOrders {
  late List<Order> orders;
  late String phoneNumber;
  late String location;
  late String orderId;
  late String date;

  ClientAllOrders(this.orders, this.phoneNumber, this.location, this.orderId, this.date);

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
    };
  }
}
