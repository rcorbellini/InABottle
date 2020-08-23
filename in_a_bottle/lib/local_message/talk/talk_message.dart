import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

class TalkMessage extends Message {
  TalkMessage({
    selector,
    text,
    title,
    owner,
    local,
    reactions = const <UserReaction>{},
  }) : super(
          selector: selector,
          text: text,
          title: title,
          owner: owner,
          local: local,
          reactions: reactions = const <UserReaction>{},
        );
}
