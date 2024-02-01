import 'package:a_rosa_je/models/advice.dart';
import 'package:a_rosa_je/models/plant.dart';

class Visit {
  String id;
  String guardId;
  DateTime date;
  String? comment;
  List<Advice>? botanistAdvice = [];
  List<Plant>? plants = [];

  Visit({
    required this.id,
    required this.guardId,
    required this.date,
    this.comment,
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
      plants: json['plants'] != null
          ? (json['plants'] as List)
              .map((plant) => Plant.fromJson(plant))
              .toList()
          : null,
    );
  }
}
