import 'package:a_rosa_je/Models/conversation.dart';
import 'package:a_rosa_je/Models/user.dart';

class Message {
  String id;
  Conversation conversation;
  User user;
  String content;
  DateTime createdAt;

  Message({
    required this.id,
    required this.conversation,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  static fromJson(message) {}
}
