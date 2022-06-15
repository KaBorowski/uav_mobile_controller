// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // sign in with email & password
//   Future signInEmailPassword(
//       {required String email, required String password}) async {
//     try {
//       var result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       User? user = result.user;
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   // sign in with google

//   // register with email & password
//   Future registerUser({required String email, required String password}) async {
//     try {
//       var userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return userCredential.user;
//     } catch (e) {
//       if (e == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       } else {
//         print(e);
//       }
//       return null;
//     }
//   }

//   // sign out
// }
