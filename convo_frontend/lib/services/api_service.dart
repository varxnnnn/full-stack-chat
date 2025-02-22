import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000"; // Use 10.0.2.2 for emulator

  static Future<Map<String, dynamic>?> registerUser(
      String name, String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/api/register");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print("Response: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed to register"};
      }
    } catch (e) {
      print("Error: $e");
      return {"error": "Something went wrong"};
    }
  }
}
