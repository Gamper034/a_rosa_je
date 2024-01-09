import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/plant_visit.dart';
import 'package:a_rosa_je/models/guard.dart';

class Plant {
  String id;
  Guard guard;
  DateTime date;
  List<PlantVisit>? plant = [];
  String? comment;
  List<Advice>? advice = [];

  Plant({
    required this.id,
    required this.guard,
    required this.date,
    this.plant,
    this.comment,
    this.advice,
  });
}
