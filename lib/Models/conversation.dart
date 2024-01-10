import 'package:a_rosa_je/Models/message.dart';
import 'package:a_rosa_je/models/guard.dart';

class Conversation {
  String id;
  Guard guard;
  List<Message>? messages = [];
  DateTime createdAt;

  Conversation({
    required this.id,
    required this.guard,
    this.messages,
    required this.createdAt,
  });
}
