import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:a_rosa_je/screens/register_page.dart'; // Remplacez par le chemin de votre fichier

void main() {
  group('Inscriptions', () {
    test("Inscrire un utilisateur avec succès.", () async {
      String role = "user";
      String firstname = "Toto";
      String lastname = "Doe";
      String email = "toto.doe@hotmail.com";
      String password = "john123";
      var result =
          await registerUser(role, firstname, lastname, email, password);

      expect(result['statusCode'], 200);
    });

    test("Inscrire d'un botaniste avec succès.", () async {
      String role = "botanist";
      String firstname = "Titi";
      String lastname = "Doe";
      String email = "titi.doe@hotmail.com";
      String siret = "12345678912345";
      String password = "john123";
      var result = await registerBotanist(
          role, firstname, lastname, email, siret, password);

      expect(result['statusCode'], 200);
    });
  });
}
