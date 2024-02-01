import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:a_rosa_je/models/plant.dart';
import 'package:a_rosa_je/models/plant_visit.dart';

class Visit {
  String id;
  String guardId;
  DateTime date;
  String? comment;
  Guard? guard;
  List<Advice>? botanistAdvice = [];
  List<PlantVisit>? plants = [];

  Visit({
    required this.id,
    required this.guardId,
    required this.date,
    this.comment,
    this.guard,
    this.botanistAdvice,
    this.plants,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'],
      guardId: json['guardId'],
      date: DateTime.parse(json['date']),
      comment: json['comment'] ?? null,
      // botanistAdvice: json['botanistAdvice'] != null
      //     ? (json['botanistAdvice'] as List)
      //         .map((advice) => Advice.fromJson(advice))
      //         .toList()
      //     : null,
      guard: json['guard'] != null ? Guard.fromJson(json['guard']) : null,
      plants: (json['plants'] as List<dynamic>)
          .map((item) => PlantVisit.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
