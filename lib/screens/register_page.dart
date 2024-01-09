import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/screens/login_page.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isUserForm = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                      top: screenHeight * 0.1,
                      bottom: screenHeight * 0.05,
                    ),
                    child: Container(
                      width: 110,
                      height: 110,
                      child:
                          Image.asset('assets/images/logos/logo_vert_noir.png'),
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
                          // Ajoutez les autres propriétés pour conserver le style du bouton
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
                          // Ajoutez les autres propriétés pour conserver le style du bouton
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
                    padding: const EdgeInsets.only(top: 20),
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
                                    ), // Remplacez par votre page d'inscription
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
  String? _firstname, _lastname, _email, _password, _siret;

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
              onSaved: (value) => _firstname = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Nom",
              onSaved: (value) => _lastname = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Email",
              onSaved: (value) => _email = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "N° de SIRET",
              onSaved: (value) => _siret = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
            ),
            CustomTextField(
              color: textColor,
              hintText: "Mot de passe",
              obscureText: true,
              onSaved: (value) => _password = value,
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
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Vous pouvez maintenant utiliser _username, _email et _password
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>
    //           ConfirmSignUp()), // Remplacez par votre page d'inscription
    // );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? _firstname, _lastname, _email, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Prénom",
            onSaved: (value) => _firstname = value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Nom",
            onSaved: (value) => _lastname = value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Email",
            onSaved: (value) => _email = value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
          ),
          CustomTextField(
            color: AppColors.textColor,
            hintText: "Mot de passe",
            obscureText: true,
            onSaved: (value) => _password = value,
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
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Vous pouvez maintenant utiliser _username, _email et _password
    }
    //Rediriger vers la page login
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>
    //           LoginPage()), // Remplacez par votre page d'inscription
    // );
  }
}
