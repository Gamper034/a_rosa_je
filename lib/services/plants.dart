import 'dart:convert';

import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PlantService {
  final storage = new FlutterSecureStorage();

  Future<List<String>> getPlantsType() async {
    DataApi dataApi = DataApi();
    //read jwt from storage
    String? jwtTemp = await storage.read(key: 'jwt');
    if (jwtTemp == null) {
      throw Exception('JWT is null');
    }
    String jwt = jwtTemp;

    var response = await dataApi.getPlantsType(jwt);

    List<String> plantsType = [];

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var plant in body) {
        plantsType.add(plant['name']);
      }

      return plantsType;
    } else {
      throw Exception('Failed to load plants');
    }
  }
}
