// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['fullName'] as String?,
      json['phoneNumber'] as String?,
      json['uid'] as String?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'uid': instance.uid,
    };

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
      json['id'] as String?,
      json['image'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['stars'] as int?,
      $enumDecodeNullable(_$ItemCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'stars': instance.stars,
      'category': _$ItemCategoryEnumMap[instance.category],
    };

const _$ItemCategoryEnumMap = {
  ItemCategory.FASTFOOD: 'FASTFOOD',
  ItemCategory.DRINK: 'DRINK',
  ItemCategory.SNACK: 'SNACK',
  ItemCategory.DESSERT: 'DESSERT',
  ItemCategory.PIZZA: 'PIZZA',
  ItemCategory.BURGER: 'BURGER',
  ItemCategory.HOTDOG: 'HOTDOG',
};

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      json['itemResponse'] == null
          ? null
          : ItemResponse.fromJson(json['itemResponse'] as Map<String, dynamic>),
      json['quentity'] as int?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'itemResponse': instance.itemResponse,
      'quentity': instance.quentity,
    };

OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) =>
    OrdersResponse(
      (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['phoneNumber'] as String,
      json['location'] as String,
      json['orderId'] as String,
    )..date = json['date'] as String;

Map<String, dynamic> _$OrdersResponseToJson(OrdersResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'orderId': instance.orderId,
      'date': instance.date,
    };
