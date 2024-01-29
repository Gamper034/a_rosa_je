import 'dart:convert';

import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/services/api/data_api.dart';
import 'package:a_rosa_je/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lucide_icons/lucide_icons.dart';
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

  Map<String, dynamic> getStatus(Guard guard) {
    Map<String, dynamic> statusInfo = {};

    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime startDate = DateTime(
        guard.startDate.year, guard.startDate.month, guard.startDate.day);
    DateTime endDate =
        DateTime(guard.endDate.year, guard.endDate.month, guard.endDate.day);

    print(today);

    if ((guard.startDate.isBefore(today) ||
            guard.startDate.isAtSameMomentAs(today)) &&
        (guard.endDate.isAfter(today) ||
            guard.endDate.isAtSameMomentAs(today))) {
      //La date de début est avant la date actuelle et la date de fin est après la date actuelle
      statusInfo['text'] = "En cours";
      statusInfo['color'] = primaryColor;
      statusInfo['icon'] = LucideIcons.hourglass;
    } else if (guard.startDate.isBefore(today) &&
        guard.endDate.isBefore(today)) {
      //Date de début et de fin passées
      statusInfo['text'] = "Terminée";
      statusInfo['color'] = greenSolid;
      statusInfo['icon'] = LucideIcons.bookmarkMinus;
    } else {
      if (guard.applications != null && guard.applications!.length > 0) {
        //La garde a des candidatures et n'est pas passée
        statusInfo['text'] = "Candidature en attente";
        statusInfo['color'] = warningColor;
        statusInfo['icon'] = LucideIcons.hourglass;
      } else {
        //La garde n'a pas de candidatures et n'est pas passée
        statusInfo['text'] = "A venir";
        statusInfo['color'] = blueBadge;
        statusInfo['icon'] = LucideIcons.calendar;
      }
    }

    return statusInfo;
  }
}
