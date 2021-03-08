import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';

abstract class InteractDirectMessageEvent {}

class LoadDirectMessage extends InteractDirectMessageEvent {
  final String selector;

  LoadDirectMessage(this.selector);
}

class SelectReaction extends InteractDirectMessageEvent {
  final TypeReaction reaction;
  final DirectMessage message;

  SelectReaction(this.reaction, this.message);
}
