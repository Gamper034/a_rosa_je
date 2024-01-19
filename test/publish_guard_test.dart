import 'package:flutter_test/flutter_test.dart';
import 'package:a_rosa_je/services/api/data_api.dart';

void main() {
  group('Création d\'une garde', () {
    DataApi dataApi = DataApi();
    test("Créer une garde avec succès.", () async {
      String startDate = "2021-05-01";
      String endDate = "2021-05-02";
      String address = "1 rue de la paix";
      String city = "Paris";
      String zipcode = "75000";
      List<Map<String, dynamic>> plants = [];
      plants.add({
        "plantName1": "Monsterra",
        "plantType1": "Plante verte",
        "plantImage":
            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ikea.com%2Ffr%2Ffr%2Fp%2Fmonstera-plant"
      });

      var response = await dataApi.addGuard(
          startDate, endDate, address, city, zipcode, plants);

      expect(response.statusCode, 200);
    });
  });
}
