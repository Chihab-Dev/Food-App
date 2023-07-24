import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth;

  FirebaseAuthentication(this._auth);

  // Future<void> verifyPhoneNumber(
  //   String phoneNumber, {
  //   required Function(String verificationId) onSent,
  //   required Function(FirebaseAuthException error) onFailed,
  // }) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     codeSent: (String verificationId, int? resendToken) {
  //       onSent(verificationId);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {},
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  Future<OtpCheckModel> otpCheck(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    UserCredential credentials = await _auth.signInWithCredential(credential);

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(credentials.user!.uid).get();

    return OtpCheckModel(documentSnapshot, credentials);
  }

  Future<void> verifyPhoneNumber(VerifyPhoneNumberModel parameter) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: parameter.phoneNumber,
      verificationCompleted: parameter.verificationCompleted,
      verificationFailed: parameter.verificationFailed,
      codeSent: parameter.codeSent,
      codeAutoRetrievalTimeout: parameter.codeAutoRetrievalTimeout,
      timeout: parameter.timeout,
    );
  }

  Future<void> userRegister(UserRegister userRegister) async {
    await _auth.currentUser!.updateDisplayName(userRegister.fullName);
  }
}

class UserRegister {
  String phoneNumber;
  String uid;
  String fullName;

  UserRegister(this.fullName, this.phoneNumber, this.uid);
}

class VerifyPhoneNumberModel {
  String phoneNumber;
  Function(PhoneAuthCredential) verificationCompleted;
  Function(FirebaseAuthException) verificationFailed;
  Function(String, int?) codeSent;
  Function(String) codeAutoRetrievalTimeout;
  Duration timeout = const Duration(seconds: 30);

  VerifyPhoneNumberModel(
    this.phoneNumber,
    this.verificationCompleted,
    this.verificationFailed,
    this.codeSent,
    this.codeAutoRetrievalTimeout,
    this.timeout,
  );
}

class OtpCheckModel {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  UserCredential credentials;

  OtpCheckModel(this.documentSnapshot, this.credentials);
}
