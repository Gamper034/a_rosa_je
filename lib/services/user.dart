// services/user.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_rosa_je/models/user.dart';
import 'dart:convert';

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

  Future<void> checkLoginStatus(BuildContext context) async {
    // Obtenir une instance de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lire les données utilisateur
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      // Convertir la chaîne JSON en Map<String, dynamic>
      Map<String, dynamic> userMap = jsonDecode(userJson);

      // Construire l'objet User
      User user = User.fromJson(userMap);

      // Utiliser l'objet User
      print(user);

      // Naviguer vers l'écran d'accueil si l'utilisateur est déjà connecté
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Naviguer vers l'écran de connexion si l'utilisateur n'est pas connecté
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void logout(context) async {
    await storage.delete(key: 'jwt');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<User> getUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      User user = User.fromJson(userMap);
      return user;
    }

    throw Exception('No user found');
  }
}
