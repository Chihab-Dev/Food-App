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

  ItemResponse(this.image, this.title, this.description, this.price, this.stars);

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
  List<OrderResponse>? orders;
  @JsonKey(name: 'phoneNumber')
  String phoneNumber;
  @JsonKey(name: 'location')
  String location;

  OrdersResponse(this.orders, this.phoneNumber, this.location);

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => _$OrdersResponseFromJson(json);
}
