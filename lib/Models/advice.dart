import 'package:a_rosa_je/models/user.dart';
import 'package:a_rosa_je/models/visit.dart';
import 'package:a_rosa_je/models/guard.dart';
import 'package:flutter/foundation.dart';

class Advice {
  String id;
  User user;
  String referer; // "Guard" or "Visit"
  Guard? guard;
  Visit? visit;
  String? visitId;
  String content;
  DateTime createdAt;

  Advice({
    required this.id,
    required this.user,
    required this.referer,
    this.guard,
    this.visit,
    this.visitId,
    required this.content,
    required this.createdAt,
  });

//FromJson
  factory Advice.fromJson(Map<String, dynamic> json) {
    // if (json['data']['advices'].isEmpty) {
    //   throw Exception('No advices found');
    // }

    return Advice(
      id: json['id'],
      user: User.fromJson(json['user']),
      referer: json['referer'],
      guard: json['guard'] != null ? Guard.fromJson(json['guard']) : null,
      visit: json['visit'] != null ? Visit.fromJson(json['visit']) : null,
      visitId: json['visitId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // bool get isEmpty => content.isEmpty;
}
