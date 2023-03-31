abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

// Name Validation

class RegisterNameValidState extends RegisterStates {}

class RegisterNameNotValidState extends RegisterStates {}

// User Create

class RegisterUserCreateLoadingState extends RegisterStates {}

class RegisterUserCreateSuccessState extends RegisterStates {}

class RegisterUserCreateErrorState extends RegisterStates {
  final String error;
  RegisterUserCreateErrorState(this.error);
}

// update current user name

class RegisterUpdateCurrentUserNameLoadingState extends RegisterStates {}

class RegisterUpdateCurrentUserNameSuccessState extends RegisterStates {}

class RegisterUpdateCurrentUserNameErrorState extends RegisterStates {
  final String error;
  RegisterUpdateCurrentUserNameErrorState(this.error);
}
