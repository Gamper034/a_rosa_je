import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/models/guard.dart';

class Visit {
  String id;
  Guard guard;
  DateTime date;
  List<Plant>? plants = [];
  String? comment;
  List<Advice>? advice = [];

  Visit({
    required this.id,
    required this.guard,
    required this.date,
    this.plants,
    this.comment,
    this.advice,
  });
}
