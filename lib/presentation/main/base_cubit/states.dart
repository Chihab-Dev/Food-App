abstract class BaseStates {}

class BaseInitialState extends BaseStates {}

// change index

class BaseChangeIndexState extends BaseStates {}

// get user data

class BaseGetUserDataLoadingState extends BaseStates {}

class BaseGetUserDataSuccessState extends BaseStates {}

class BaseGetUserDataErrorState extends BaseStates {
  final String error;

  BaseGetUserDataErrorState(this.error);
}

// get popular items

class BaseGetPopularItemsLoadingState extends BaseStates {}

class BaseGetPopularItemsSuccessState extends BaseStates {}

class BaseGetPopularItemsErrorState extends BaseStates {
  final String error;

  BaseGetPopularItemsErrorState(this.error);
}

// get  items

class BaseGetItemsLoadingState extends BaseStates {}

class BaseGetItemsSuccessState extends BaseStates {}

class BaseGetItemsErrorState extends BaseStates {
  final String error;

  BaseGetItemsErrorState(this.error);
}

// order item state

// add item

class BaseAddOrderToCartSuccessState extends BaseStates {}

class BaseAddOrderToCartErrorState extends BaseStates {
  final String error;

  BaseAddOrderToCartErrorState(this.error);
}

// remove order

class BaseRemoveOrderSuccessState extends BaseStates {}

// sent order to firebase

class SentOrderToFirebaseLoadingState extends BaseStates {}

class SentOrderToFirebaseSuccessState extends BaseStates {}

class SentOrderToFirebaseErrorState extends BaseStates {
  final String error;

  SentOrderToFirebaseErrorState(this.error);
}

// remove meal

class BaseRemoveMealSuccessState extends BaseStates {}

// get meals by category

class GetMealsByCategoryState extends BaseStates {}

// search item

class SearchItemState extends BaseStates {}

// get real time order state

class GetRealTimeOrderStateLiveState extends BaseStates {}

class GetRealTimeOrderStateLoadingState extends BaseStates {}

class GetRealTimeOrderStateSuccessState extends BaseStates {}

class GetRealTimeOrderStateErrorState extends BaseStates {
  final String error;

  GetRealTimeOrderStateErrorState(this.error);
}

class OrderDoneState extends BaseStates {}

// ADD item to favorite list

class AddItemToFavoriteLoadingState extends BaseStates {}

class AddItemToFavoriteSuccessState extends BaseStates {}

class AddItemToFavoriteErrorState extends BaseStates {
  final String error;

  AddItemToFavoriteErrorState(this.error);
}

// Remove item to favorite list

class RemoveItemFromFavoriteLoadingState extends BaseStates {}

class RemoveItemFromFavoriteSuccessState extends BaseStates {}

class RemoveItemFromFavoriteErrorState extends BaseStates {
  final String error;

  RemoveItemFromFavoriteErrorState(this.error);
}

// get location states

class GetCurrentLocationLoadingState extends BaseStates {}

class GetCurrentLocationSuccessState extends BaseStates {}

class GetCurrentLocationErrorState extends BaseStates {
  final String error;

  GetCurrentLocationErrorState(this.error);
}

class GetLocationNameLoadingState extends BaseStates {}

class GetLocationNameSuccessState extends BaseStates {}

class GetLocationNameErrorState extends BaseStates {
  final String error;

  GetLocationNameErrorState(this.error);
}

// is store open

class GetIsStoreOpenLoadingState extends BaseStates {}

class GetIsStoreOpenSuccessState extends BaseStates {}

class GetIsStoreOpenErrorState extends BaseStates {
  final String error;

  GetIsStoreOpenErrorState(this.error);
}

// change is store open

class ChangeIsStoreOpenLoadingState extends BaseStates {}

class ChangeIsStoreOpenSuccessState extends BaseStates {}

class ChangeIsStoreOpenErrorState extends BaseStates {
  final String error;

  ChangeIsStoreOpenErrorState(this.error);
}

// timer

class ChangeTimerState extends BaseStates {}

// delete order from firebase

class DeleteOrderFromFirebaseLoadingState extends BaseStates {}

class DeleteOrderFromFirebaseSuccessState extends BaseStates {}

class DeleteOrderFromFirebaseErrorState extends BaseStates {
  final String error;

  DeleteOrderFromFirebaseErrorState(this.error);
}
