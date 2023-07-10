import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:postgres/postgres.dart';
import 'package:samaki_social_app/SamakiHomeScreen/SamakiHomeScreen.dart';
import 'package:samaki_social_app/login/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../services/apiService.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;


class ComplexLoginScreen extends StatefulWidget {
  @override
  _ComplexLoginScreenState createState() => _ComplexLoginScreenState();
}

class _ComplexLoginScreenState extends State<ComplexLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService = ApiService();




  /*******************applesignIn***********/
  Future<void> _signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      final authResult = await _auth.signInWithCredential(oauthCredential);
      final user = authResult.user;

      if (user != null) {
        final idToken = await user.getIdToken();

        print('Apple ID Token: $idToken');

        final parts = idToken.split('.');
        final payload = parts[1];
        final padding = '=' * (4 - (payload.length % 4));
        final paddedPayload = payload + padding;

        final decoded = base64Url.decode(paddedPayload);
        final decodedJson = utf8.decode(decoded);
        final Map<String, dynamic> decodedToken = jsonDecode(decodedJson);

        final String username = decodedToken['name'];
        final String uid = decodedToken['user_id'];

        print('Username: $username');
        print('UID: $uid');

        // Continue with your logic or make an API request using the extracted data
        String imageURL = "https://example.com/image.jpg"; // Replace with the actual image URL
        String userId = "$uid"; // Replace with the actual user ID

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('userId', uid);
        await prefs.setString('image', imageURL);
        await prefs.setString('token', idToken);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SamakiHomeScreen(),
          ),
        );
      }
    } catch (error) {
      print('Sign in with Apple error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  /****************signinwithApple************/

  /**************googlesignIn***********/
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        final String username = user.displayName ?? '';
        final String uid = user.uid;
        final String photoUrl = user.photoURL ?? 'https://example.com/default.jpg';
        final String jwt = googleAuth.idToken ?? '';

        // Decode the JWT token to extract the user details
        final parts = jwt.split('.');
        final payload = parts[1];
        final normalized = base64Url.normalize(payload);
        final decoded = utf8.decode(base64Url.decode(normalized));
        final Map<String, dynamic> decodedToken = jsonDecode(decoded);

        final String email = decodedToken['email'];
        if (email == null) {
          throw Exception("Email not found in decoded token");
        }

        // Check if the email exists in Firebase
        final emailExists = await _checkEmailExists(email);
        if (emailExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email already exists'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SamakiHomeScreen(),
            ),
          );
          return; // Don't register the user
        }

        // Save the user details to the Firebase Firestore database
        FirebaseFirestore db = FirebaseFirestore.instance;
        CollectionReference usersRef = db.collection('users');
        await usersRef.doc(uid).set({
          'user_id':uid,
          'username': username,
          'email': email,
          'photoUrl': photoUrl,
        });

        // Save the JWT and other details to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('userId', uid);
        await prefs.setString('image', photoUrl);
        await prefs.setString('token', jwt);

        print("JWT Token: $jwt");
        print("USER ID: $uid");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SamakiHomeScreen(),
          ),
        );
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  Future<bool> _checkEmailExists(String email) async {
    try {
      final result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }


  /*********googlesignIn***********/
  /**************_signInWithEmailAndPassword*****/
  // Future<void> _signInWithEmailAndPasswordFirebase() async {
  //   try {
  //     final ApiService apiService = ApiService();
  //     final User user = await userloginWithEmailPassword(
  //       _emailController.text,
  //       _passwordController.text,
  //       context,
  //     );
  //     print(user);
  //     // Navigate to home screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => SamakiHomeScreen()),
  //     );
  //
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  /**************_signInWithEmailAndPassword*****/
  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;

      String? imageURL;
      String? username;
      String? userId;

      if (firebaseUser != null) {
        // Get the user's photo URL
        imageURL = firebaseUser.photoURL;

        // Get the user's display name
        username = firebaseUser.displayName;

        // Get the user's UID
        userId = firebaseUser.uid;

        // Save data to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('imageURL', imageURL ?? "https://example.com/default.jpg");
        prefs.setString('username', username ?? "JohnDoe");
        prefs.setString('userId', userId ?? "");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SamakiHomeScreen(),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }










  //////////_signInWithEmailAndPassword////////


  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
              ],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                'Welcome to Samaki App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Please sign in to continue.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white38, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white70),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white38, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(height: 20),
              FractionallySizedBox(
                widthFactor: 0.9, // Set to a value less than 1.0
                child: ElevatedButton(
                  onPressed: () {
                    _signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                  },

                  child: Text('Sign In'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurple.shade300),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 15)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                 // Navigate to sign up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Or sign in with',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Implement sign in with Google_signIn
                      _signInWithGoogle();
                    },
                    icon: Image.asset('assets/images/google_logo.png'),
                    iconSize: 35,
                  ),
                  IconButton(
                    onPressed: () {
                     // Implement sign in with Apple
                      _signInWithApple;
                    },
                    icon: Icon(
                      Icons.apple,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}