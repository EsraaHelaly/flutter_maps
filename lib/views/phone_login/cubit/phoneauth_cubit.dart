import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  static PhoneAuthCubit get(context) => BlocProvider.of(context);
  String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 15),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) async {
    print('verificationFailed : ${error.toString()}');
    emit(PhoneAuthError(error.toString()));
  }

  void codeSent(String verificationId, int resendToken) {
    this.verificationId = verificationId;
    print('codeSent');
    emit(PhoneAuthSucsess());
  }

  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpSucsess());
    } catch (error) {
      emit(PhoneAuthError(error.toString()));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
