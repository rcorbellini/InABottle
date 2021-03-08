import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';

abstract class InteractHubMessageEvent {}

class LoadChat extends InteractHubMessageEvent {
  final String selector;

  LoadChat(this.selector);
}

class SelectReaction extends InteractHubMessageEvent {
  final TypeReaction reaction;
  final Message messageChat;

  SelectReaction(this.reaction, this.messageChat);
}