import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ApiService {
  // User Registration
  Future<bool> registerUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.apiUrl}/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        print('Registration successful');
        return true;
      } else {
        print('Registration failed: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('Failed to connect to the server');
    }
  }

  // User Login
  Future<String?> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', token); // Save JWT token locally
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }
}