abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthSucsess extends PhoneAuthState {}

class PhoneOtpSucsess extends PhoneAuthState {}



class PhoneAuthError extends PhoneAuthState {
  final String error;

  PhoneAuthError(this.error);
}
