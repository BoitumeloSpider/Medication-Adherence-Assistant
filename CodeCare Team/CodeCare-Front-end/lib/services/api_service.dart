import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/users/register';

  // REGISTER
  static Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"] ?? response.body
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // LOGIN
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"] ?? response.body
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // FORGOT PASSWORD / USERNAME
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/forgot');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"] ?? response.body
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}