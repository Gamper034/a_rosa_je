import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/components/CustomTextField.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Image.asset('assets/images/logos/logo_blanc.png'),
              ),
              // Spacer(),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    hintText: 'Email',
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    hintText: 'Mot de passe',
                    obscureText: true,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomButton(
                    onPressed: () {
                      // Ajoutez votre logique de connexion ici
                    },
                    label: 'Se connecter',
                  ),
                ),
              ),
              Spacer(flex: 2),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Pas encore de compte ? ',
                    style: TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'S\'inscrire',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage()), // Remplacez par votre page d'inscription
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
