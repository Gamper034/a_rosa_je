import 'package:flutter/material.dart';
import 'package:a_rosa_je/widgets/button.dart';
import 'package:a_rosa_je/widgets/text_field.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/services/botanist.dart';

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
  String errorMessage = '';

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
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      BotanistService user = BotanistService();
      String result = await user.confirmRegisterBotanist(
        context,
        _role,
        _firstname,
        _lastname,
        _email,
        _siret,
        _password,
      );

      setState(() {
        errorMessage = result;
      });
    }
  }
}
