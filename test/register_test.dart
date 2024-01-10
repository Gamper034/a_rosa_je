import 'package:flutter_test/flutter_test.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

void main() {
  group('Inscriptions', () {
    DataApi dataApi = DataApi();
    test("Inscrire un utilisateur avec succès.", () async {
      String role = "user";
      String firstname = "dfgdfgdfg";
      String lastname = "dfgdfgdfg";
      String email = "toto.doe@dfgdfgdfg.com";
      String password = "dfgdfgdfg";
      var result = await dataApi.registerUser(
          role, firstname, lastname, email, password);

      expect(result['statusCode'], 201);
    });

    test("Inscrire d'un botaniste avec succès.", () async {
      String role = "botanist";
      String firstname = "fgfg";
      String lastname = "ff";
      String email = "titi.doe@azert.com";
      String siret = "12345678912345";
      String password = "john123";
      var result = await dataApi.registerBotanist(
          role, firstname, lastname, email, siret, password);

      expect(result['statusCode'], 201);
    });
  });
}
