// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthentication {
//   final FirebaseAuth _auth;

//   FirebaseAuthentication(this._auth);

//   Future<void> verifyPhoneNumber(
//     String phoneNumber, {
//     required Function(String verificationId) onSent,
//     required Function(FirebaseAuthException error) onFailed,
//   }) async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       codeSent: (String verificationId, int? resendToken) {
//         onSent(verificationId);
//       },
//       verificationFailed: (FirebaseAuthException e) {},
//       verificationCompleted: (PhoneAuthCredential credential) {},
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }


// }

