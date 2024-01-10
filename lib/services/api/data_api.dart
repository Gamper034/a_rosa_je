import 'package:http/http.dart' as http;
import 'dart:convert';

class DataApi {
  Future<Map<String, dynamic>> registerUser(String role, String firstname,
      String lastname, String email, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': role,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> registerBotanist(String role, String firstname,
      String lastname, String email, String siret, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': role,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'siret': siret,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
}
