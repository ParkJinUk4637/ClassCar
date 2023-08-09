//
//
// import 'package:firebase_auth/firebase_auth.dart';
//
// class PhoneVerify {
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<void> verify(String phoneNumber) async {
//     await auth.verifyPhoneNumber(
//       timeout: const Duration(seconds: 60),
//       phoneNumber: "+82 10 3918 7724",
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential);
//         print("success");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('The provided phone number is not valid.');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         // Update the UI - wait for the user to enter the SMS code
//         String smsCode = '010807';
//
//         // Create a PhoneAuthCredential with the code
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//
//         // Sign the user in (or link) with the credential
//         await auth.signInWithCredential(credential);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         print(verificationId);
//       },
//     );
//   }
// }
//
// import 'package:firebase_auth/firebase_auth.dart';
//
// class PhoneVerify {
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<void> verify(String phoneNumber) async {
//     await auth.verifyPhoneNumber(
//       timeout: const Duration(seconds: 60),
//       phoneNumber: "+82 10 3918 7724",
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential);
//         print("success");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('The provided phone number is not valid.');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         // Update the UI - wait for the user to enter the SMS code
//         String smsCode = '010807';
//
//         // Create a PhoneAuthCredential with the code
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//
//         // Sign the user in (or link) with the credential
//         await auth.signInWithCredential(credential);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         print(verificationId);
//       },
//     );
//   }
// }