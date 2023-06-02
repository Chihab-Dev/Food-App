class CustomerObject {
  String fullName;
  String phoneNumber;
  String uid;

  CustomerObject(this.fullName, this.phoneNumber, this.uid);
}

class ItemObject {
  String image;
  String title;
  String description;
  int price;
  int stars;

  ItemObject(
    this.image,
    this.title,
    this.description,
    this.price,
    this.stars,
  );
}

class Order {
  ItemObject itemObject;
  int quentity;

  Order(this.itemObject, this.quentity);
}

class Orders {
  List<Order> orders;
  String phoneNumber;
  String location;
  String orderId;

  Orders(this.orders, this.phoneNumber, this.location, this.orderId);

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
    };
  }
}
