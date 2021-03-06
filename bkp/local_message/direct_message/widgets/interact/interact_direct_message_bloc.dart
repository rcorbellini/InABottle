import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_repository.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_event.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';

class InteractDirectMessageBloc extends BaseBloc<InteractDirectMessageEvent> {
  static const String route = '/interactDirectMessage';
  final DirectMessageRepository messageRepository;
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
      TypeReaction reaction, DirectMessage directMessage) async {
    final entity = await _buildEntity();

    final session = await sessionRepository.load();
    final reactionOfUser =
        UserReaction(createdBy: session.user, reaction: reaction);

    bool exist = directMessage.message.reactions.contains(reactionOfUser);

    if (exist) {
      directMessage.message.reactions.remove(reactionOfUser);
    } else {
      directMessage.message.reactions.add(reactionOfUser);
    }

    await messageRepository.save(entity);

    final hubReactionsCounted =
        await messageRepository.loadByKey(entity.selector);

    _updateHubOnScreen(hubReactionsCounted);
  }

  void _updateHubOnScreen(DirectMessage entity) {
    dispatchOn<DirectMessage>(entity, key: DirectMessageForm.directMessage);
  }

  Future<DirectMessage> _buildEntity() async {
    final map = valuesToMap<DirectMessageForm>();

    return map[DirectMessageForm.directMessage] as DirectMessage;
  }
}

enum DirectMessageForm { directMessage }
