import 'package:a_rosa_je/services/user.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

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
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
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
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Sauvegarde les valeurs des champs
      DataApi user = DataApi();
      String result = await user.registerUser(
        context,
        _role,
        _firstname,
        _lastname,
        _email,
        _password,
      );

      setState(() {
        errorMessage = result;
      });
    }
  }
}
