// import 'dart:convert';
//
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:samaki_social_app/SamakiHomeScreen/SamakiHomeScreen.dart';
// import 'package:samaki_social_app/services/postgres_service.dart';
// import '../login/auth_service.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   final AuthService _authService = AuthService();
//   bool _passwordVisible = false;
//   bool _confirmPasswordVisible = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _formKey =
//   GlobalKey<FormState>(); // You need to use this key in your Form widget
//
//
//
//   @override
//   void initState() {
//     _passwordVisible = false;
//     _confirmPasswordVisible = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.deepPurple,
//                 Colors.deepPurpleAccent,
//               ],
//             ),
//           ),
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 100),
//               Text(
//                 'Create an account',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 36,
//                 ),
//               ),
//               SizedBox(height: 15),
//               Text(
//                 'Sign up to get started.',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 40),
//               Form(
//                 // Wrap your TextFormField widgets inside a Form
//                 key: _formKey, // Assign the GlobalKey you defined earlier
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (val) => val!.isEmpty
//                           ? 'Enter an email'
//                           : null, // Add email validation
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: TextStyle(color: Colors.white70),
//                         fillColor: Colors.white24,
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white38, width: 1.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white, width: 1.0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _passwordController,
//                       keyboardType: TextInputType.visiblePassword,
//                       obscureText: !_passwordVisible,
//                       validator: (val) => val!.length < 6
//                           ? 'Enter a password 6+ chars long'
//                           : null,
//                       // Add password validation
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: TextStyle(color: Colors.white70),
//                         fillColor: Colors.white24,
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white38, width: 1.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white, width: 1.0),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _passwordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                             color: Colors.white70,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _passwordVisible = !_passwordVisible;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       keyboardType: TextInputType.visiblePassword,
//                       obscureText: !_confirmPasswordVisible,
//                       validator: (val) => val != _passwordController.text
//                           ? 'Passwords do not match'
//                           : null,
//                       // Add confirm password validation
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         labelStyle: TextStyle(color: Colors.white70),
//                         fillColor: Colors.white24,
//                         filled: true,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white38, width: 1.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.white, width: 1.0),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _confirmPasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                             color: Colors.white70,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _confirmPasswordVisible =
//                               !_confirmPasswordVisible;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               FractionallySizedBox(
//                 widthFactor: 0.9, // Set to a value less than 1.0
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // Check if the form is valid
//                     if (_formKey.currentState!.validate()) {
//                       // Implement sign-up logic
//                       UserCredential? result =
//                       await _authService.registerWithEmailAndPassword(
//                           _emailController.text, _passwordController.text);
//                       if (result != null) {
//
//                         // Navigate to the next screen after successful registration
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SamakiHomeScreen()),
//                         );
//                       } else {
//                         // Show an error message
//                       }
//                     }
//                   },
//                   child: Text('Sign Up'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         Colors.deepPurple.shade300),
//                     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                         EdgeInsets.symmetric(vertical: 15)),
//                     textStyle: MaterialStateProperty.all<TextStyle>(
//                       TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Already have an account?',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to sign-in screen
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Or sign up with',
//                 style: TextStyle(color: Colors.white70),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       // Implement sign-up logic
//                       if (_formKey.currentState!.validate()) {
//                         UserCredential? result =
//                         await _authService.registerWithEmailAndPassword(
//                             _emailController.text,
//                             _passwordController.text);
//                         if (result != null) {
//                           // Add the user to the PostgreSQL database
//
//
//                           // Navigate to the next screen after successful registration
//                         } else {
//                           // Show an error message
//                         }
//                       }
//                     },
//                     icon: Image.asset('assets/images/google_logo.png'),
//                     iconSize: 35,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       // Implement sign up with Apple
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SamakiHomeScreen()),
//                       );
//                     },
//                     icon: Icon(
//                       Icons.apple,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
