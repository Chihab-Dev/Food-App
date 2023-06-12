import 'package:food_app/app/constants.dart';
import 'package:food_app/app/extensions.dart';
import 'package:food_app/data/response/responses.dart';
import 'package:food_app/domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerObject toDomain() {
    return CustomerObject(
      this?.fullName.orEmpty() ?? Constants.empty,
      this?.phoneNumber.orEmpty() ?? Constants.empty,
      this?.uid.orEmpty() ?? Constants.empty,
    );
  }
}

extension ItemResponseMapper on ItemResponse? {
  ItemObject toDomain() {
    return ItemObject(
      this?.id.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.title.orEmpty() ?? Constants.empty,
      this?.description.orEmpty() ?? Constants.empty,
      this?.price.orZero() ?? Constants.zero,
      this?.stars.orZero() ?? Constants.zero,
      this?.category.orDefaultCategory() ?? ItemCategory.FASTFOOD,
      this?.calories.orZero() ?? Constants.zero,
      this?.preparationTime.orZero() ?? Constants.zero,
    );
  }
}

extension OrderResponseMapper on OrderResponse? {
  Order toDomain() {
    return Order(
      this?.itemResponse.toDomain() ??
          ItemObject(
            Constants.empty,
            Constants.empty,
            Constants.empty,
            Constants.empty,
            Constants.zero,
            Constants.zero,
            ItemCategory.FASTFOOD,
            Constants.zero,
            Constants.zero,
          ),
      this?.quentity.orZero() ?? Constants.zero,
    );
  }
}

extension OrdersResponseMapper on OrdersResponse? {
  ClientAllOrders toDomain() {
    List<Order> orders =
        (this?.orders?.map((order) => order.toDomain()) ?? const Iterable.empty()).cast<Order>().toList();

    return ClientAllOrders(
      orders,
      this?.phoneNumber.orEmpty() ?? Constants.empty,
      this?.location.orEmpty() ?? Constants.empty,
      this?.orderId.orEmpty() ?? Constants.empty,
      this?.date.orEmpty() ?? Constants.empty,
    );
  }
}

// extension ItemObjectMapper on ItemObject {
//   ItemResponse toResponse() {
//     return ItemResponse(image, title, description, price, stars);
//   }
// }


// extension OrdersResponseMapper on OrdersResponse? {
//   Orders toDomain() {
//     List<Order> orders = (this?.orders?.map(
//                   (order) => order.toDomain(),
//                 ) ??
//             const Iterable.empty())
//         .cast<Order>()
//         .toList();

//     return Orders(
//       orders,
//       this?.phoneNumber.orEmpty() ?? Constants.empty,
//       this?.location.orEmpty() ?? Constants.empty,
//     );
//   }
// }
