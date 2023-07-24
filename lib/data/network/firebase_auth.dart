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
}

class OtpCheckModel {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  UserCredential credentials;

  OtpCheckModel(this.documentSnapshot, this.credentials);
}
