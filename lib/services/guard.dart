import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardService {
  final storage = FlutterSecureStorage();
  Future<void> addGuard(BuildContext context, startDate, String endDate,
      String address, String zipCode, String city, List plants) async {
    DataApi dataApi = DataApi();
    var response = await dataApi.addGuard(
        startDate, endDate, address, zipCode, city, plants);

    if (response.statusCode == 200) {
      print('Status code: ${response.statusCode}');

      print('Created guard!!!!!!!!!!!');
      Navigator.pushReplacementNamed(context, '/home');
    } else if (response.statusCode == 401) {
      await storage.delete(key: 'jwt');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('user');
      Navigator.pushReplacementNamed(context, '/login');
      print('Status code: ${response.statusCode}');
    } else {
      print('Status code: ${response.statusCode}');
      print('Reason phrase: ${response.reasonPhrase}');
    }
  }
}
