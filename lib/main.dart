import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/screens/confirm_sign_up.dart';
import 'package:a_rosa_je/screens/home_page.dart';
import 'package:a_rosa_je/screens/register_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/confirmSignUp': (context) => ConfirmSignUp(),
        '/home': (context) => HomePage(),
        'signup': (context) => RegisterPage(),
      },
    ),
  );
}
