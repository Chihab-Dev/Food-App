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

class BaseAddOrderSuccessState extends BaseStates {}

class BaseAddOrderErrorState extends BaseStates {
  final String error;

  BaseAddOrderErrorState(this.error);
}

// remove item

class BaseRemoveOrderSuccessState extends BaseStates {}

// sent order to firebase

class SentOrderToFirebaseLoadingState extends BaseStates {}

class SentOrderToFirebaseSuccessState extends BaseStates {}

class SentOrderToFirebaseErrorState extends BaseStates {
  final String error;

  SentOrderToFirebaseErrorState(this.error);
}

