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
