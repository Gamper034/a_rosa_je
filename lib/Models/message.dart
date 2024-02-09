import 'package:a_rosa_je/models/conversation.dart';
import 'package:a_rosa_je/models/user.dart';

class Message {
  String id;
  String conversationId;
  User user;
  String content;
  DateTime createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  static fromJson(message) {}
}
