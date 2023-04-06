abstract class BaseStates {}

class BaseInitialState extends BaseStates {}

class BaseGetUserDataLoadingState extends BaseStates {}

class BaseGetUserDataSucessState extends BaseStates {}

class BaseGetUserDataErrorState extends BaseStates {
  final String error;

  BaseGetUserDataErrorState(this.error);
}
