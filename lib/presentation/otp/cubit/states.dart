abstract class OtpStates {}

class OtpInittialState extends OtpStates {}

// is sms code valid ::

class OtpCheckLoadingState extends OtpStates {}

class OtpCheckSuccessState extends OtpStates {}

class OtpCheckErrorState extends OtpStates {}

// is sms code correct

class OtpSmsCodeValidState extends OtpStates {}

class OtpSmsCodeNotValidState extends OtpStates {}

// is new user
class OtpOldUserState extends OtpStates {}

class OtpNewUserState extends OtpStates {}
