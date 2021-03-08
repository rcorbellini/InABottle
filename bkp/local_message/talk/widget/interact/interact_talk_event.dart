import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';

abstract class InteractTalkEvent{

}

class LoadTalk extends InteractTalkEvent{
    final String selector;

  LoadTalk(this.selector);

}

class SelectReaction extends InteractTalkEvent{
  final TypeReaction reaction;
  final Message message;

  SelectReaction(this.reaction, this.message);
}

class TabChange extends InteractTalkEvent{
  final int index;

  TabChange(this.index);
}