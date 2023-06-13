abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

// get orders from firebase

class GetOrdersFromFirebaseLoadingState extends AdminStates {}

class GetOrdersFromFirebaseSuccessState extends AdminStates {}

class GetOrdersFromFirebaseErrorState extends AdminStates {
  final String error;

  GetOrdersFromFirebaseErrorState(this.error);
}

// delete order from firebase

class DeleteOrderFromFirebaseLoadingState extends AdminStates {}

class DeleteOrderFromFirebaseSuccessState extends AdminStates {}

class DeleteOrderFromFirebaseErrorState extends AdminStates {
  final String error;

  DeleteOrderFromFirebaseErrorState(this.error);
}

// change order from firebase

class ChangeOrderStateLoadingState extends AdminStates {}

class ChangeOrderStateSuccessState extends AdminStates {}

class ChangeOrderStateErrorState extends AdminStates {
  final String error;

  ChangeOrderStateErrorState(this.error);
}
