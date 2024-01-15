import 'package:a_rosa_je/pages/login/login_page.dart';
import 'package:a_rosa_je/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/pages/register/confirm_sign_up.dart';
import 'package:a_rosa_je/pages/home/home_page.dart';
import 'package:a_rosa_je/pages/register/register_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      supportedLocales: [
        const Locale('fr', ''), // Français
        // Autres locales...
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    ),
  );

  initializeDateFormatting('fr_FR', null);
}
