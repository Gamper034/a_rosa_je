import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/screens/confirm_sign_up.dart';

void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      title: 'Arosa Je Routes',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/confirmSignUp': (context) => ConfirmSignUp(),
      },
    ),
  );
}
