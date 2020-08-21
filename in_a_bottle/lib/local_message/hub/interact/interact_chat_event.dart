import 'package:in_a_bottle/local_message/hub/message_chat.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

abstract class InteractChatEvent {}

class LoadChat extends InteractChatEvent {
  final String selector;

  LoadChat(this.selector);
}

class SelectReaction extends InteractChatEvent {
  final TypeReaction reaction;
  final MessageChat messageChat;

  SelectReaction(this.reaction, this.messageChat);
}
