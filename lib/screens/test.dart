// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:postgres/postgres.dart';
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
//   final PostgresService _postgresService = PostgresService();
//   bool _passwordVisible = false;
//   bool _confirmPasswordVisible = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   late String _email;
//   late String _password;
//
//   // ...
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           // ...
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ...
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     _email = value;
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     // ...
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordController,
//                   keyboardType: TextInputType.visiblePassword,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     _password = value;
//                     return null;
//                   },
//                   obscureText: !_passwordVisible,
//                   decoration: InputDecoration(
//                     // ...
//                   ),
//                 ),
//                 // ...
//                 SizedBox(height: 20),
//                 FractionallySizedBox(
//                   widthFactor: 0.9,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // Implement sign-up logic
//                       if (_formKey.currentState!.validate()) {
//                         UserCredential? result = await _authService.registerWithEmailAndPassword(_email, _password);
//                         if (result != null) {
//                           // Add the user to the PostgreSQL database
//                           await _postgresService.addUser(result.user!, _password);
//
//                           // Navigate to the next screen after successful registration
//                         } else {
//                           // Show an error message
//                         }
//                       }
//                     },
//                     child: Text('Sign Up'),
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           Colors.deepPurple.shade300),
//                       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                           EdgeInsets.symmetric(vertical: 15)),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                         TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // ...
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }