import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/components/text_field.dart';
// import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Image.asset('assets/images/logos/logo_blanc.png'),
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    hintText: 'Email',
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    hintText: 'Mot de passe',
                    obscureText: true,
                    color: Colors.white,
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 10),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     child: CustomButton(
              //       onPressed: () {
              //         // Ajoutez votre logique de connexion ici
              //       },
              //       label: 'Se connecter',
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(onPressed: () {}, label: "Se connecter"),
              ),
              Spacer(flex: 2),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Pas encore de compte ? ',
                    style: test,
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
