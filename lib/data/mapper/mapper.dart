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
      this?.image.orEmpty() ?? Constants.empty,
      this?.title.orEmpty() ?? Constants.empty,
      this?.description.orEmpty() ?? Constants.empty,
      this?.price.orZero() ?? Constants.zero,
      this?.stars.orZero() ?? Constants.zero,
    );
  }
}
