import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';

abstract class InteractDirectMessageEvent {}

class LoadDirectMessage extends InteractDirectMessageEvent {
  final String selector;

  LoadDirectMessage(this.selector);
}

class SelectReaction extends InteractDirectMessageEvent {
  final TypeReaction reaction;
  final Message message;

  SelectReaction(this.reaction, this.message);
}
