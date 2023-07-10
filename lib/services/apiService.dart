import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/user2.dart';
import '../models/user3.dart';

class ApiService {
 // final String url = "http://192.168.43.26:5900";
 final String url = "http://192.168.100.26:5900";
  //192.168.100.26

  String parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));

    return resp;
  }

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Users> getUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Users(
      user_id: prefs.getString('user_id'),
      email: prefs.getString('email'),
      username: prefs.getString('username'),
      profile_picture: prefs.getString('profile_picture'),
      token: prefs.getString('token'),
    );

  }

  Future<void> saveUserToPrefs(Users user) async {
    final prefs = await SharedPreferences.getInstance();

    if (user.user_id != null) {
      prefs.setString('user_id', user.user_id!);
    }
    if (user.email != null) {
      prefs.setString('email', user.email!);
    }
    if (user.token != null) {
      prefs.setString('token', user.token!);
    }
    print("sharedPreference : ${user.token}");
    print("sharedPreference : ${user.email}");
  }

  Future<void> saveUserToPrefss(Users2 user) async {
    final prefs = await SharedPreferences.getInstance();

    if (user.user_id != null) {
      prefs.setString('user_id', user.user_id!);
    }
    if (user.email != null) {
      prefs.setString('email', user.email!);
    }
    if (user.token != null) {
      prefs.setString('token', user.token!);
    }
    print("sharedPreference : ${user.token}");
    print("sharedPreference : ${user.email}");
  }

  Future<void> saveUserToPrefsSearch(Users3 user) async {
  final prefs = await SharedPreferences.getInstance();

  if (user.user_id != null) {
    prefs.setString('user_id', user.user_id!);
  }
  if (user.email != null) {
    prefs.setString('email', user.email!);
  }
  if (user.token != null) {
    prefs.setString('token', user.token!);
  }
  print("sharedPreference : ${user.token}");
  print("sharedPreference : ${user.email}");
  }

  Future<Users> userRegistration(String uid, String email, String username, String photoUrl, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + '/api/v1/registration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'username': username,
          'profile_picture': photoUrl,
          'user_id': uid,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var token = jsonData['token'];
        print('Token: $token');

        Users user = Users(
          user_id: uid,
          email: email,
          username: username,
          profile_picture: photoUrl,
          token: token,
        );

        await saveUserToPrefs(user);

        return user;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }




  Future<Users> userloginWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + '/api/v1/login_session'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        final decodedToken = parseJwt(jsonData['token']);
        final payloadMap = json.decode(decodedToken);


        Users user = Users(
          user_id: payloadMap['user_id'],
          email: payloadMap['email'],
          username: payloadMap['username'],
          profile_picture: payloadMap['profile_picture'],
          token: payloadMap['token'],
        );

        await saveUserToPrefs(user);

        return user;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch(e) {
      print(e); // you can handle the error in a better way, this is for demonstration
      throw Exception('Error while connecting to API');
    }
  }
  Future<bool> createPost(Map<String, dynamic> postDetails, String? token) async {
    print(token);
    final String postEndPoint = '/api/v1/posts'; // Replace with your actual endpoint

    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse(url + postEndPoint),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(postDetails),
        );

        print('Response status code: ${response.statusCode}');

        if ( response.statusCode != 201) {
          print('Response body: ${response.body}');
          var jsonData = jsonDecode(response.body);
          String errorMessage = jsonData['error'];
          if (errorMessage == null || errorMessage.isEmpty) {
            errorMessage = 'An error occurred';
          }
          throw Exception(errorMessage);
        }

        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      throw Exception('No token provided');
    }
  }

  Future<List<Users2>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse(url + '/api/v1/users'),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;

        List<Users2> users = jsonData.map((userJson) => Users2.fromJson(userJson)).toList();

        // Save the user data to shared preferences
        for (var user in users) {
          await saveUserToPrefss(user);
        }

        // Print the user data
        for (var user in users) {
          print('User ID: ${user.user_id}');
          print('Email: ${user.email}');
          print('Username: ${user.username}');
          print('Profile Picture: ${user.profile_picture}');
          print('---------------------------');
        }

        print('Retrieved and saved all users');
        return users;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }

  Future<List<Users3>> searchUsers(String query) async {
    try {
      final response = await http.get(
        Uri.parse(url + '/api/v1/search?query=$query'),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;

        List<Users3> users = jsonData.map((userJson) => Users3.fromJson(userJson)).toList();

        // Save the user data to shared preferences
        for (var user in users) {
          await saveUserToPrefsSearch(user);
        }

        // Print the user data
        for (var user in users) {
          print('User ID: ${user.user_id}');
          print('Email: ${user.email}');
          print('Username: ${user.username}');
          print('Profile Picture: ${user.profile_picture}');
          print('---------------------------');
        }

        print('Retrieved and saved search results');
        return users;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }

}



