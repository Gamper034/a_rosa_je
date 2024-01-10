import 'package:flutter/material.dart';
import 'package:a_rosa_je/services/user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      UserService userService = UserService();
      userService.checkLoginStatus(context);
      // userService.logout(context);
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
              widthFactor: 0.3,
              child: Image.asset('assets/images/logos/png/logo_noir.png'),
            ),
          ],
        ),
      ),
    );
  }
}
