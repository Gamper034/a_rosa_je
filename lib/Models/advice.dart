import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/models/guard.dart';

class Advice {
  String id;
  User user;
  String Referer; // "Guard" or "Visit"
  Guard? guard;
  Visit? visit;
  String content;
  DateTime createdAt;

  Advice({
    required this.id,
    required this.user,
    required this.Referer,
    this.guard,
    this.visit,
    required this.content,
    required this.createdAt,
  });

  static fromJson(advice) {}
}
