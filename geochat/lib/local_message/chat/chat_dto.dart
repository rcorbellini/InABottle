import 'package:geochat/local_message/chat/message_chat_dto.dart';
import 'package:geochat/local_message/local/local_dto.dart';
import 'package:geochat/user/user_dto.dart';

class Chat{
  final Local local;
  final List<User> admin;
  final String title;  
  final List<MessageChat> messageChat;

  Chat({this.local, this.admin, this.title, this.messageChat});
}