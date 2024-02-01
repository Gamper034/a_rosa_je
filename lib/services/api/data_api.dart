import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class DataApi {
  final storage = new FlutterSecureStorage();

  static String getHost() {
    if (kIsWeb) {
      return 'localhost';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return '10.0.2.2';
      case TargetPlatform.iOS:
        return 'localhost';
      default:
        return 'localhost';
    }
  }

  Future<String> registerUser(BuildContext context, String role,
      String firstname, String lastname, String email, String password) async {
    try {
      final Map<String, dynamic> registrationData = {
        'role': role,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://${getHost()}:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      String errorMessage;
      var json = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/login');
        errorMessage = '';
      } else if (response.statusCode == 400 &&
          json['message'] == 'User already exists') {
        errorMessage = 'L\'utilisateur existe déjà.';
      } else if (response.statusCode == 400 &&
          json['message'] == "Invalid email") {
        errorMessage = 'L\'email est invalide.';
      } else {
        print(response.statusCode);
        // print('Response body: ${json}');

        errorMessage = 'Une erreur est survenue.';
      }

      return errorMessage;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<String> registerBotanist(
      BuildContext context,
      String role,
      String firstname,
      String lastname,
      String email,
      String siret,
      String password) async {
    String errorMessage;
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
        Uri.parse('http://${getHost()}:2000/api/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registrationData),
      );

      var json = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/confirmSignUp');
        errorMessage = '';
      } else if (response.statusCode == 400 &&
          json['message'] == 'User already exists') {
        errorMessage = 'Le botaniste existe déjà.';
      } else if (response.statusCode == 400 &&
          json['message'] == "Invalid email") {
        errorMessage = 'L\'email est invalide.';
      } else {
        print(response.statusCode);
        // print('Response body: ${json['message']}');

        errorMessage = 'Une erreur est survenue.';
      }

      return errorMessage;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> getGuardList(
      List<String> selectedPlantTypeList, String selectedVille) async {
    try {
      Map<String, dynamic> filters;

      filters = {
        'filters': {
          "city": selectedVille,
          "plantTypes": selectedPlantTypeList,
        },
      };

      String? jwt = await storage.read(key: 'jwt');

      final response = await http.post(
        Uri.parse('http://${getHost()}:2000/api/guard/availables'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': '$jwt',
        },
        body: jsonEncode(filters),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to get guard list: $e');
    }
  }

  Future<Map<String, dynamic>> addGuard(
      BuildContext context,
      String startDate,
      String endDate,
      String address,
      String zipCode,
      String city,
      List plants) async {
    try {
      String? jwt = await storage.read(key: 'jwt');
      var headers = {
        'Cookie': '$jwt',
      };
      // print(jwt);
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://${getHost()}:2000/api/guard/add'));
      request.fields.addAll({
        'startDate': startDate,
        'endDate': endDate,
        'address': address,
        'zipCode': zipCode,
        'city': city,
      });

      for (var i = 0; i < plants.length; i++) {
        request.fields['plantName${i + 1}'] = plants[i]['plantName'];
        request.fields['plantType${i + 1}'] = plants[i]['selectedPlantType'];
        var multipartFile = await http.MultipartFile.fromPath(
          'plantImage',
          plants[i]['plantImageUrl'],
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
      //

      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 401) {
        UserService.logout(context);
      }
      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to add guard: $e');
    }
  }

  Future<Map<String, dynamic>> getPlantTypeList() async {
    try {
      String? jwt = await storage.read(key: 'jwt');

      final response = await http.get(
        Uri.parse('http://${getHost()}:2000/api/plant/getTypes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': '$jwt',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      throw Exception('Failed to get guard list: $e');
    }
  }

  Future<List<String>> getPlantsType() async {
    try {
      final response = await http.get(
        Uri.parse('http://${getHost()}:2000/api/plant/getTypes'),
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

  Future<Map<String, dynamic>> getOwnerGuards() async {
    //Récupérer l'id de l'utilisateur
    UserService userService = UserService();
    User owner = await userService.getUserPreferences();

    //Récupérer le jwt
    String? jwt = await storage.read(key: 'jwt');

    var request = http.Request('GET',
        Uri.parse('http://${getHost()}:2000/api/guard/user/${owner.id}'));

    request.headers['Cookie'] = '$jwt';

    http.StreamedResponse response = await request.send();

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(await response.stream.bytesToString()),
    };
    // return {
    //   'statusCode': response.statusCode,
    //   'body': jsonDecode(response()),
    // };
  }

  Future<Map<String, dynamic>> getGuardAdvices(
      BuildContext context, guardId) async {
    //Récupérer le jwt
    String? jwt = await storage.read(key: 'jwt');
    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Cookie': '$jwt',
    // };
    // var request = http.Request(
    //     'GET', Uri.parse('http://localhost:2000/api/advice/guard/${guardId}'));
    // request.body = '''''';
    // request.headers.addAll(headers);

    final response = await http.get(
      Uri.parse('http://${getHost()}:2000/api/advice/guard/${guardId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '$jwt',
      },
    );

    if (response.statusCode == 401) {
      UserService.logout(context);
    }

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>> publishGuardAdvice(
      String guardId, String content) async {
    String? jwt = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': '$jwt',
    };
    var request = http.Request(
        'POST', Uri.parse('http://${getHost()}:2000/api/advice/guard/add'));
    request.body = json.encode({"guardId": guardId, "content": content});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // print(response.statusCode);
    return {
      'statusCode': response.statusCode,
    };
  }

  Future<Map<String, dynamic>> publishVisitAdvice(
      String visitId, String content) async {
    String? jwt = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': '$jwt',
    };
    var request = http.Request(
        'POST', Uri.parse('http://${getHost()}:2000/api/advice/visit/add'));
    request.body = json.encode({"visitId": visitId, "content": content});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // print(response.statusCode);
    return {
      'statusCode': response.statusCode,
    };
  }

  Future<Map<String, dynamic>> getGuardVisits(
      BuildContext context, guardId) async {
    String? jwt = await storage.read(key: 'jwt');
    // print(jwt);

    final response = await http.get(
      Uri.parse('http://${getHost()}:2000/api/visit/guard/${guardId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '$jwt',
      },
    );

    if (response.statusCode == 401) {
      UserService.logout(context);
    }

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>> addVisit(BuildContext context, String visitDate,
      String comment, List plantImages, String guardId) async {
    String? jwt = await storage.read(key: 'jwt');
    var headers = {
      'Cookie': '$jwt',
    };
    // print(jwt);
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://${getHost()}:2000/api/visit/add/${guardId}'));
    request.fields.addAll({
      'date': visitDate,
      'comment': comment,
    });

    for (var i = 0; i < plantImages.length; i++) {
      var multipartFile = await http.MultipartFile.fromPath(
        'plantImage',
        plantImages[i],
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    //

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401) {
      UserService.logout(context);
    }

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>> getVisit(
      BuildContext context, String visitId) async {
    String? jwt = await storage.read(key: 'jwt');
    // print(jwt);

    final response = await http.get(
      Uri.parse('http://${getHost()}:2000/api/visit/${visitId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '$jwt',
      },
    );

    if (response.statusCode == 401) {
      UserService.logout(context);
    }
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>> getVisitAdvices(
      BuildContext context, String visitId) async {
    String? jwt = await storage.read(key: 'jwt');
    // print(jwt);

    final response = await http.get(
      Uri.parse('http://${getHost()}:2000/api/advice/visit/${visitId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '$jwt',
      },
    );

    if (response.statusCode == 401) {
      UserService.logout(context);
    }
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }
}
