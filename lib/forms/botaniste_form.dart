// user_form.dart
import 'package:flutter/material.dart';
import 'package:a_rosa_je/components/text_field.dart';
import 'package:a_rosa_je/constants.dart';
import 'package:a_rosa_je/components/button.dart';
import 'package:a_rosa_je/screens/confirm_sign_up.dart';

class BotanistForm extends StatefulWidget {
  @override
  _BotanistFormState createState() => _BotanistFormState();
}

class _BotanistFormState extends State<BotanistForm> {
  final _formKey = GlobalKey<FormState>();
  String? _firstname, _lastname, _email, _password, _siret;

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
            hintText: "N° de SIRET",
            onSaved: (value) => _siret = value,
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
    // if (_formKey.currentState?.validate() ?? false) {
    //   _formKey.currentState?.save();
    //   // Vous pouvez maintenant utiliser _username, _email et _password
    // }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ConfirmSignUp()), // Remplacez par votre page d'inscription
    );
  }
}
