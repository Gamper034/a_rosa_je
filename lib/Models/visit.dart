import 'package:a_rosa_je/models/advice.dart';

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
