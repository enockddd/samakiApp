// import 'package:flutter/material.dart';
//
// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   bool _passwordVisible = false;
//   bool _confirmPasswordVisible = false;
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
//                 'Create Account',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 36,
//                 ),
//               ),
//               SizedBox(height: 15),
//               Text(
//                 'Please fill in the form to sign up.',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 40),
//               TextField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: TextStyle(color: Colors.white70),
//                   fillColor: Colors.white24,
//                   filled: true,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white38, width: 1.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 keyboardType: TextInputType.visiblePassword,
//                 obscureText: !_passwordVisible,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: TextStyle(color: Colors.white70),
//                   fillColor: Colors.white24,
//                   filled: true,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white38, width: 1.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.0),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _passwordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.white70,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _passwordVisible = !_passwordVisible;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _confirmPasswordController,
//                 keyboardType: TextInputType.visiblePassword,
//                 obscureText: !_confirmPasswordVisible,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   labelStyle: TextStyle(color: Colors.white70),
//                   fillColor: Colors.white24,
//                   filled: true,
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white38, width: 1.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white, width: 1.0),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _confirmPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.white70,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _confirmPasswordVisible = !_confirmPasswordVisible;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Implement sign up logic
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
//                   SizedBox(width: 5),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to the login screen
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(color: Colors.white),
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
