import 'package:a_rosa_je/models/message.dart';
import 'package:a_rosa_je/models/guard.dart';

class Conversation {
  String id;
  String guard;
  List<Message>? messages = [];
  DateTime createdAt;

  Conversation({
    required this.id,
    required this.guard,
    this.messages,
    required this.createdAt,
  });

  static fromJson(json) {
    return Conversation(
      id: json['id'],
      guard: "*",
      messages: [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
