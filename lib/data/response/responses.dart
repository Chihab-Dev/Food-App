// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'fullName')
  String? fullName;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'uid')
  String? uid;

  CustomerResponse(this.fullName, this.phoneNumber, this.uid);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ItemResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'stars')
  int? stars;

  ItemResponse(this.id, this.image, this.title, this.description, this.price, this.stars);

  factory ItemResponse.fromJson(Map<String, dynamic> json) => _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: 'itemResponse')
  ItemResponse? itemResponse;
  @JsonKey(name: 'quentity')
  int? quentity;

  OrderResponse(this.itemResponse, this.quentity);

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrdersResponse {
  @JsonKey(name: 'orders')
  late List<OrderResponse>? orders;
  @JsonKey(name: 'phoneNumber')
  late String phoneNumber;
  @JsonKey(name: 'location')
  late String location;
  @JsonKey(name: 'orderId')
  late String orderId;
  @JsonKey(name: 'date')
  late String date;

  OrdersResponse(this.orders, this.phoneNumber, this.location, this.orderId);

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    var ordersList = json["orders"] as List;
    List<OrderResponse> orders = ordersList.map(
      (orderResponse) {
        var itemResponseJson = orderResponse["itemObject"];
        ItemResponse itemResponse = ItemResponse(
          itemResponseJson["id"],
          itemResponseJson["image"],
          itemResponseJson["title"],
          itemResponseJson["description"],
          itemResponseJson["price"],
          itemResponseJson["stars"],
        );
        var quentity = orderResponse["quentity"];

        return OrderResponse(itemResponse, quentity);
      },
    ).toList();

    this.orders = orders;
    phoneNumber = json["phoneNumber"];
    location = json["location"];
    orderId = json["orderId"];
    date = json["date"];
  }

  // OrdersResponse.fromJson(Map<String, dynamic> json) {
  //   var ordersList = json["orders"] as List;
  //   List<OrderResponse> OrderResponse = ordersList.map((OrderResponse) {
  //     var ItemResponseJson = OrderResponse["OrderResponse"];
  //     var ItemResponse = ItemResponse(
  //       image: ItemResponseJson["image"],
  //       title: ItemResponseJson["title"],
  //       description: ItemResponseJson["description"],
  //       price: ItemResponseJson["price"],
  //       stars: ItemResponseJson["stars"],
  //     );

  //     var quentity = OrderResponse["quentity"];

  //     return OrderResponse(ItemResponse, quentity);
  //   }).toList();
  // }
}
