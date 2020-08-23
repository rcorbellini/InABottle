import 'package:in_a_bottle/local_message/hub/chat_message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

abstract class InteractChatEvent {}

class LoadChat extends InteractChatEvent {
  final String selector;

  LoadChat(this.selector);
}

class SelectReaction extends InteractChatEvent {
  final TypeReaction reaction;
  final ChatMessage messageChat;

  SelectReaction(this.reaction, this.messageChat);
}