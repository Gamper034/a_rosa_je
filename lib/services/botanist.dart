import 'package:a_rosa_je/services/user.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

class BotanistService extends UserService {
  Future<String> confirmRegisterBotanist(
      context, role, firstname, lastname, email, siret, password) async {
    String errorMessage;
    DataApi dataApi = DataApi();
    var result = await dataApi.registerBotanist(
        role, firstname, lastname, email, siret, password);

    if (result['statusCode'] == 201) {
      Navigator.pushReplacementNamed(context, '/confirmSignUp');
      errorMessage = '';
    } else if (result['statusCode'] == 400 &&
        result['body']['message'] == 'User already exists') {
      errorMessage = 'Le botaniste existe déjà.';
    } else if (result['statusCode'] == 400 &&
        result['body']['message'] == "Invalid email") {
      errorMessage = 'L\'email est invalide.';
    } else {
      print('Failed to register user. Status code: ${result['statusCode']}');
      print('Response body: ${result['body']}');

      errorMessage = 'Une erreur est survenue.';
    }

    return errorMessage;
  }
}
