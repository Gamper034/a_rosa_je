import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class DataApi {
  String getHost() {
    if (kIsWeb) {
      return 'localhost';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return '10.0.2.2';
      case TargetPlatform.iOS:
        return 'localhost';
      default:
        return 'localhost';
    }
  }

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
        Uri.parse('http://${getHost()}:2000/api/user/register'),
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
        Uri.parse('http://${getHost()}:2000/api/user/register'),
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
