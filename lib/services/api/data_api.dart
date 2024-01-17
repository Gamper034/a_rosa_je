import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class DataApi {
  Future<Map<String, dynamic>> registerUser(String role, String firstname,
      String lastname, String email, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': role,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> registerBotanist(String role, String firstname,
      String lastname, String email, String siret, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': role,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'siret': siret,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://localhost:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> addGuard(String startDate, String endDate,
      String address, String zipCode, String city, List plants) async {
    try {
      final Map<String, dynamic> guardData = {
        'startDate': startDate,
        'endDate': endDate,
        'address': address,
        'zipCode': zipCode,
        'city': city,
        'plantImages': [],
      };

      for (var i = 0; i < plants.length; i++) {
        guardData['plantName$i'] = plants[i]['plantName'];
        guardData['plantType$i'] = plants[i]['plantType'];

        String imagePath = plants[i]['plantImageUrl'];
        String base64Image = base64Encode(File(imagePath).readAsBytesSync());
        guardData['plantImages'].add(base64Image);
      }
      final response = await http.post(
        Uri.parse('http://localhost:2000/api/guard/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(guardData),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to add guard: $e');
    }
  }

  Future<List<String>> getPlantsType() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:2000/api/plant/getTypes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<String> plantsType = [];

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        for (var plant in body) {
          plantsType.add(plant['name']);
        }
      }

      return plantsType;
    } catch (e) {
      throw Exception('Failed to get plants type: $e');
    }
  }
}
