import 'package:flutter/material.dart';
import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/screens/home_page.dart'; // Importez votre page d'accueil
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    String? jwt = await storage.read(key: 'jwt');
    if (jwt == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Vérifiez le JWT avec votre API
      final response = await http.post(
        Uri.parse('http://localhost:1000/api/checkToken'),
        body: jsonEncode(<String, String>{
          'jwt': jwt,
        }),
      );

      if (response.statusCode == 200) {
        // Si le JWT est valide, redirigez vers la page d'accueil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Si le JWT n'est pas valide, redirigez vers la page de connexion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.3,
              child: Image.asset('assets/images/logos/png/logo_noir.png'),
            ),
          ],
        ),
      ),
    );
  }
}
