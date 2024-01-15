import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_rosa_je/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class AuthApi {
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

  final storage = FlutterSecureStorage();

  Future<String> authentification(
      context, String email, String password) async {
    var body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse('http://${getHost()}:1000/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        print('Login successful');
        String rawCookie = response.headers['set-cookie']!;
        int index = rawCookie.indexOf(';');
        String jwt = (index == -1) ? rawCookie : rawCookie.substring(0, index);
        await storage.write(key: 'jwt', value: jwt);
        // Récupérer les données utilisateur de la réponse
        Map<String, dynamic> userMap = responseBody['data']['user'];
        // Construire l'objet User
        User user = User.fromJson(userMap);

        // Convertir l'objet User en JSON
        String userJson = jsonEncode(user.toJson());

        // Obtenir une instance de SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Stocker les données utilisateur
        await prefs.setString('user', userJson);
        Navigator.pushReplacementNamed(context, '/home');
        return '';
      } else if (response.statusCode == 401 &&
          responseBody['message'] == 'Identifiants incorrects') {
        print(response.body);
        return 'Identifiants incorrects. Veuillez réessayez.';
      } else if (responseBody['message'] ==
          'Votre compte est en attente de validation') {
        print(response.body);
        print('not verified');
        return 'Votre compte est en attente de validation par un administrateur.';
      } else {
        print(response.body);
        print(body);
        return 'Problème de connexion. Veuillez réessayer.';
      }
    } catch (e) {
      print('An error occurred: $e');
      return 'Une erreur est survenue. Veuillez réessayer.';
    }
  }
}
