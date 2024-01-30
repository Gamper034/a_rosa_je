import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/widgets/button.dart';
import 'package:a_rosa_je/widgets/text_field.dart';
// import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/pages/register/register_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:a_rosa_je/services/api/auth_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  String email = '';
  String password = '';
  Future<String>? auth;

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
                child: Image.asset(
                  'assets/images/logos/png/logo_blanc.png',
                ),
              ),
              // Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    color: Colors.white,
                    colorText: Colors.white,
                    hintText: "Email",
                    onSaved: (value) => email = value ?? '',
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
                    colorText: Colors.white,
                    obscureText: true,
                    onSaved: (value) => password = value ?? '',
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
                    onPressed: _login,
                    label: 'Se connecter',
                    buttonColor: Colors.white,
                    textColor: primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Center(
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
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

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      AuthApi authApi = AuthApi();
      String result = await authApi.authentification(
        context,
        email,
        password,
      );

      setState(() {
        errorMessage = result;
      });
    }
  }
}
