import 'dart:convert';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GuardStatus { aVenir, enCours, termine, enAttente, defaultStatus }

class GuardService {
  GuardStatus getStatus(Guard guard) {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime startDate = DateTime(
        guard.startDate.year, guard.startDate.month, guard.startDate.day);
    DateTime endDate =
        DateTime(guard.endDate.year, guard.endDate.month, guard.endDate.day);
    if ((startDate.isBefore(today) || startDate.isAtSameMomentAs(today)) &&
        (endDate.isAfter(today) || endDate.isAtSameMomentAs(today))) {
      return GuardStatus.enCours;
    } else if (startDate.isAfter(today)) {
      if (guard.applicants!.length > 0) {
        return GuardStatus.enAttente;
      } else {
        return GuardStatus.aVenir;
      }
    } else if (endDate.isBefore(today)) {
      return GuardStatus.termine;
    }
    return GuardStatus.defaultStatus;
  }

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
