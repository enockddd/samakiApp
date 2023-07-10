import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpApi {
  static const String _baseUrl = 'http://localhost:5000'; // Replace with your API server URL

  static Future<Map<String, dynamic>> signUp(String email, String password) async {
    final response = await http.post(Uri.parse('$_baseUrl/src/users'), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up user');
    }
  }
}