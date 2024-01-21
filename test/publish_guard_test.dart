import 'package:flutter_test/flutter_test.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

void main() {
  group('Création d\'une garde', () {
    DataApi dataApi = DataApi();

    test("Récupérer les différents types de plantes", () async {
      //Admin jwt
      String jwt =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmM2NkMmZlOC1mZTA5LTQ3NzUtYmY2OS1mYzVjNjZhNzRjNzgiLCJleHAiOjE3MDYxMTYwMTYwNDUsImlhdCI6MTcwNTUxMTIxNn0.AxtoUHJzTWES_joTjKi_lF90SWO0kOfNq2w133d5bhc";
      var response = await dataApi.getPlantsType(jwt);

      expect(response.statusCode, 200);
    });

    // test("Créer une garde avec succès.", () async {
    //   String startDate = "01-05-2021";
    //   String endDate = "02-05-2021";
    //   String address = "1 rue de la paix";
    //   String city = "Paris";
    //   String zipCode = "75000";
    //   List<Map<String, dynamic>> plants = [
    //     {
    //       "plantName": "Monsterra",
    //       "plantType": "Plante verte",
    //       "plantImageUrl": "assets/images/guzmania-1.jpg"
    //     }
    //   ];

    //   //Admin jwt
    //   String jwt =
    //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmM2NkMmZlOC1mZTA5LTQ3NzUtYmY2OS1mYzVjNjZhNzRjNzgiLCJleHAiOjE3MDYxMTYwMTYwNDUsImlhdCI6MTcwNTUxMTIxNn0.AxtoUHJzTWES_joTjKi_lF90SWO0kOfNq2w133d5bhc";

    //   var response = await dataApi.addGuard(
    //       jwt, startDate, endDate, address, city, zipCode, plants);

    //   expect(response.statusCode, 200);
    // });

    // test("Créer une garde sans Token valide.", () async {
    //   String startDate = "01-05-2021";
    //   String endDate = "02-05-2021";
    //   String address = "1 rue de la paix";
    //   String city = "Paris";
    //   String zipCode = "75000";
    //   List<Map<String, dynamic>> plants = [
    //     {
    //       "plantName": "Monsterra",
    //       "plantType": "Plante verte",
    //       "plantImageUrl": "assets/images/guzmania-1.jpg"
    //     }
    //   ];

    //   //Admin jwt
    //   String jwt = "toto";

    //   var response = await dataApi.addGuard(
    //       jwt, startDate, endDate, address, city, zipCode, plants);

    //   expect(response.statusCode, 401);
    // });
  });
}
