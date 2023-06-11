import 'package:food_app/app/constants.dart';
import 'package:food_app/domain/model/models.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullCategory on ItemCategory? {
  ItemCategory orDefaultCategory() {
    if (this == null) {
      return ItemCategory.FASTFOOD;
    } else {
      return this!;
    }
  }
}
