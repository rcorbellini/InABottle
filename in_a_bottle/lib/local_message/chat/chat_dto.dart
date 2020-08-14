import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/chat/message_chat_dto.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Chat implements HomeFeed{
  final Local local;
  final List<User> admin;
  final String title;  
  final User createdBy;
  final List<MessageChat> messageChat;

  Chat({this.local, this.admin, this.title, this.messageChat, this.createdBy});
}