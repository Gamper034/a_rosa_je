import 'package:flutter/material.dart';
import 'package:a_rosa_je/screens/home_page.dart'; // Importez votre page d'accueil

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 0.5, // 50% de la largeur de l'écran
              child: Image.asset('assets/images/logos/logo_noir.png'),
            ),
          ],
        ),
      ),
    );
  }
}
