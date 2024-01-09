import 'package:a_rosa_je/screens/home_page.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/components/text_field.dart';
// import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/screens/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorMessage = '';

  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: SvgPicture.asset(
                  'assets/images/logos/svg/Logo_Blanc.svg',
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    color: Colors.white,
                    hintText: "Email",
                    onSaved: (value) => _email = value ?? '',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Veuillez entrer votre email'
                        : null,
                    errorColor: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    color: Colors.white,
                    hintText: "Mot de passe",
                    obscureText: true,
                    onSaved: (value) => _password = value ?? '',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Veuillez entrer votre mot de passe'
                        : null,
                    errorColor: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomButton(
                    onPressed: _submit,
                    label: 'Se connecter',
                    buttonColor: Colors.white,
                    textColor: primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Spacer(flex: 2),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Pas encore de compte ? ',
                    style: white,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'S\'inscrire',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage()),
                              ModalRoute.withName(
                                  '/signup'), // Ajout de l'argument manquant
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

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      authentification(); // Appelle la fonction pour enregistrer l'utilisateur
    }
  }

  Future<void> authentification() async {
    var body = jsonEncode(<String, String>{
      'email': _email,
      'password': _password,
    });
    try {
      final response = await http.post(
        Uri.parse('http://localhost:1000/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        print('Login successful');
        // Récupérez le JWT du cookie
        String rawCookie = response.headers['set-cookie']!;
        int index = rawCookie.indexOf(';');
        String jwt = (index == -1) ? rawCookie : rawCookie.substring(0, index);

        // Stockez le JWT
        await storage.write(key: 'jwt', value: jwt);

        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          ModalRoute.withName('/home'), // Ajout de l'argument manquant
        );
      } else {
        if (response.statusCode == 400 &&
            responseBody['message'] == 'Identifiants incorrects') {
          setState(() {
            _errorMessage =
                'Vos identifiants sont incorrects ou n\'existent pas.';
          });
        } else if (responseBody['message'] ==
            'Votre compte est en attente de validation') {
          print(response.body);
          print('not verified');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Compte Botaniste',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Votre compte est en attente de validation par un administrateur.',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Center(
                    child: CustomButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: 'Fermer',
                        textColor: primaryColor,
                        buttonColor: Colors.transparent),
                  ),
                ],
              );
            },
          );
        } else {
          print(response.body);
          print(body);
          setState(() {
            _errorMessage = 'Problème de connexion. Veuillez réessayer.';
          });
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
