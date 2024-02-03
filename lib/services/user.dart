// services/user.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_rosa_je/models/user.dart';
import 'dart:convert';

class UserService {
  final storage = FlutterSecureStorage();

  Future<void> checkLoginStatus(BuildContext context) async {
    // Obtenir une instance de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lire les données utilisateur
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      // Naviguer vers l'écran d'accueil si l'utilisateur est déjà connecté
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Naviguer vers l'écran de connexion si l'utilisateur n'est pas connecté
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static Future<void> logout(context) async {
    final storage = FlutterSecureStorage();
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

  Future<bool> isBotanist() async {
    var user = await getUserPreferences();

    if (user.role == 'botanist') {
      return true;
    } else {
      return false;
    }
  }
}
