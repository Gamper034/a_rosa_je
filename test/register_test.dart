import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:a_rosa_je/screens/register_page.dart'; // Remplacez par le chemin de votre fichier

void main() {
  group('Inscription', () {
    test("Retourne l'utilisateur si l'inscription est un succès", () async {
      String role = "user";
      String firstname = "John";
      String lastname = "Doe";
      String email = "john.doe@hotmail.com";
      String password = "john123";
    });
  });
}
