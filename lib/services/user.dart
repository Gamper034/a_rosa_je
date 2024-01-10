// services/user.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

class UserService {
  final storage = FlutterSecureStorage();

  Future<String> confirmRegisterUser(
      context, role, firstname, lastname, email, password) async {
    String errorMessage;
    DataApi dataApi = DataApi();
    var result =
        await dataApi.registerUser(role, firstname, lastname, email, password);

    if (result['statusCode'] == 201) {
      Navigator.pushReplacementNamed(context, '/login');
      errorMessage = '';
    } else if (result['statusCode'] == 400 &&
        result['body']['message'] == 'User already exists') {
      errorMessage = 'L\'utilisateur existe déjà.';
    } else if (result['statusCode'] == 400 &&
        result['body']['message'] == "Invalid email") {
      errorMessage = 'L\'email est invalide.';
    } else {
      print('Failed to register user. Status code: ${result['statusCode']}');
      print('Response body: ${result['body']}');

      errorMessage = 'Une erreur est survenue.';
    }

    return errorMessage;
  }

  void checkLoginStatus(context) async {
    String? jwt = await storage.read(key: 'jwt');
    if (jwt == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void logout(context) async {
    await storage.delete(key: 'jwt');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
