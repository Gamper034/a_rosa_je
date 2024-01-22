import 'package:a_rosa_je/Models/advice.dart';
import 'package:a_rosa_je/Models/plant.dart';
import 'package:a_rosa_je/models/guard.dart';

class Visit {
  String id;
  String guardId;
  DateTime date;
  String? comment;
  List<Advice>? botanistAdvice = [];

  Visit({
    required this.id,
    required this.guardId,
    required this.date,
    this.comment,
    this.botanistAdvice,
  });

  static fromJson(visit) {}
}
