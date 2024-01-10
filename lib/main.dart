import 'package:a_rosa_je/pages/login_page.dart';
import 'package:a_rosa_je/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/pages/register/confirm_sign_up.dart';
import 'package:a_rosa_je/pages/home_page.dart';
import 'package:a_rosa_je/pages/register/register_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => SplashScreen(),
        // Athentification
        '/login': (context) => LoginPage(),
        '/confirmSignUp': (context) => ConfirmSignUp(),
        '/signup': (context) => RegisterPage(),
        // Home
        '/home': (context) => HomePage(),
      },
    ),
  );
}
