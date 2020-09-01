import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_event.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';

class InteractDirectMessageBloc extends BaseBloc<InteractDirectMessageEvent> {
  static const String route = '/interactDirectMessage';
  final MessageRepository messageRepository;
  final SessionRepository sessionRepository;

  InteractDirectMessageBloc(
      {@required this.messageRepository, @required this.sessionRepository});

  @override
  Future<void> onEvent(InteractDirectMessageEvent event) async {
    if (event is LoadDirectMessage) {
      await _loadBySelector(event.selector);
    } else if (event is SelectReaction) {
      await _applyReaction(event.reaction, event.message);
    }
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await messageRepository.loadByKey(selector);
    _updateHubOnScreen(entity);
  }

  Future<void> _applyReaction(
      TypeReaction reaction, Message message) async {
    final entity = await _buildEntity();

    final session = await sessionRepository.load();
    final reactionOfUser =
        UserReaction(createdBy: session.user, reaction: reaction);

    bool exist = message.reactions.contains(reactionOfUser);

    if (exist) {
      message.reactions.remove(reactionOfUser);
    } else {
      message.reactions.add(reactionOfUser);
    }

    await messageRepository.save(entity);

    final hubReactionsCounted = await messageRepository.loadByKey(entity.selector);

    _updateHubOnScreen(hubReactionsCounted);
  }

  void _updateHubOnScreen(Message entity) {
    dispatchOn<Message>(entity, key: DirectMessageForm.directMessage);
  }

  Future<Message> _buildEntity() async {
    final map = valuesToMap<DirectMessageForm>();

    return map[DirectMessageForm.directMessage] as Message;
  }
}

enum DirectMessageForm { directMessage }
