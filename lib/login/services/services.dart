// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();
//
// Future<void> _signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuth =
//     await googleUser!.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     final UserCredential authResult =
//     await _auth.signInWithCredential(credential);
//     final User? user = authResult.user;
//     // Navigate to home screen
//   } catch (error) {
//     print(error);
//   }
// }
//
// // Future<void> _signInWithApple() async {
// //   try {
// //     final AuthorizationResult result = await SignInWithApple.getAppleIDCredential(
// //       scopes: [
// //         AppleIDAuthorizationScopes.email,
// //         AppleIDAuthorizationScopes.fullName,
// //       ],
// //     );
// //
// //     final AuthCredential credential = OAuthProvider("apple.com").credential(
// //       accessToken: result.credential!.accessToken,
// //       idToken: result.credential!.identityToken,
// //     );
// //
// //     final UserCredential authResult =
// //     await _auth.signInWithCredential(credential);
// //     final User? user = authResult.user;
// //     // Navigate to home screen
// //   } catch (error) {
// //     print(error);
// //   }
// // }
//
// // Future<void> _signInWithEmailAndPassword() async {
// //   try {
// //     final UserCredential authResult = await _auth.signInWithEmailAndPassword(
// //       email: _emailController.text,
// //       password: _passwordController.text,
// //     );
// //     final User? user = authResult.user;
// //     // Navigate to home screen
// //   } catch (error) {
// //     print(error);
// //   }
// // }