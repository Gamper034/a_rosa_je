import 'package:a_rosa_je/screens/confirm_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/components/text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isUserForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 80,
                      bottom: 30,
                    ),
                    child: Container(
                      width: 110,
                      height: 110,
                      child: Image.asset(
                          'assets/images/logos/png/logo_vert_noir.png'),
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Je suis:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(children: [
                      Expanded(
                        child: CustomButton(
                          buttonColor: isUserForm
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                          textColor:
                              isUserForm ? Colors.white : AppColors.textColor,
                          onPressed: () {
                            setState(() {
                              isUserForm = true;
                            });
                          },
                          label: 'Utilisateur',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          buttonColor: isUserForm
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                          textColor:
                              isUserForm ? AppColors.textColor : Colors.white,
                          onPressed: () {
                            setState(() {
                              isUserForm = false;
                            });
                          },
                          label: 'Botaniste',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.grey,
                    height: 20,
                  ),
                  SizedBox(height: 5),

                  // ...

                  isUserForm ? UserForm() : BotanistForm(),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: 'Déjà inscrit ? ',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BotanistForm extends StatefulWidget {
  @override
  _BotanistFormState createState() => _BotanistFormState();
}

class _BotanistFormState extends State<BotanistForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _siret = '';
  String _password = '';
  String _role = 'botanist';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CustomTextField(
              color: textColor,
              hintText: "Prénom",
              onSaved: (value) => _firstname = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Nom",
              onSaved: (value) => _lastname = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Email",
              onSaved: (value) => _email = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "N° de SIRET",
              onSaved: (value) => _siret = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Mot de passe",
              obscureText: true,
              onSaved: (value) => _password = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            SizedBox(height: 5),
            CustomButton(
              onPressed: _submit,
              label: 'S\'inscrire',
              buttonColor: primaryColor,
              textColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    var bodyBotanist = {
      'role': _role,
      'firstname': _firstname,
      'lastname': _lastname,
      'email': _email,
      'siret': _siret,
      'password': _password,
    };
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      registerBotanist(_role, _firstname, _lastname, _email, _siret,
          _password); // Appelle la fonction pour enregistrer l'utilisateur
    }
  }

  Future<Map<String, dynamic>> registerBotanist(String role, String firstname,
      String lastname, String email, String siret, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': _role,
        'firstname': _firstname,
        'lastname': _lastname,
        'email': _email,
        'siret': _siret,
        'password': _password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('User registered successfully');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConfirmSignUp())); // Remplacez par votre page d'inscription
        return jsonDecode(response.body);
      } else {
        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 400 &&
            responseBody['message'] == 'User already exists') {
          setState(() {
            _errorMessage = 'Le botaniste existe déjà.';
          });
          return responseBody;
        } else if (response.statusCode == 400 &&
            responseBody['message'] == "Invalid email") {
          setState(() {
            _errorMessage = 'L\'email est invalide.';
          });
          return responseBody;
        } else {
          print('Failed to register user. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          return responseBody;
        }
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _password = '';
  String _role = 'user';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Prénom",
            onSaved: (value) => _firstname = value ?? '',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Nom",
            onSaved: (value) => _lastname = value ?? '',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Email",
            onSaved: (value) => _email = value ?? '',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Mot de passe",
            obscureText: true,
            onSaved: (value) => _password = value ?? '',
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          SizedBox(height: 5),
          CustomButton(
            onPressed: _submit,
            label: 'S\'inscrire',
            buttonColor: AppColors.primaryColor,
            textColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      registerUser(_role, _firstname, _lastname, _email,
          _password); // Appelle la fonction pour enregistrer l'utilisateur
    }
  }

  Future<Map<String, dynamic>> registerUser(String role, String firstname,
      String lastname, String email, String password) async {
    final Map<String, dynamic> registrationData = {
      'role': _role,
      'firstname': _firstname,
      'lastname': _lastname,
      'email': _email,
      'password': _password,
    };
    try {
      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('User registered successfully');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage())); // Remplacez par votre page d'inscription
        return jsonDecode(response.body);
      } else {
        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 400 &&
            responseBody['message'] == 'User already exists') {
          setState(() {
            _errorMessage = 'L\'utilisateur existe déjà.';
          });
          return responseBody;
        } else if (response.statusCode == 400 &&
            responseBody['message'] == "Invalid email") {
          setState(() {
            _errorMessage = 'L\'email est invalide.';
          });
          return responseBody;
        } else {
          print('Failed to register user. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          return responseBody;
        }
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
}
