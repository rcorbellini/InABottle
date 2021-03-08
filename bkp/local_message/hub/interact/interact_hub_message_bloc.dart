import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_repository.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_event.dart';
import 'package:uuid/uuid.dart';

class InteractHubMessageBloc extends BaseBloc<InteractHubMessageEvent> {
  static const String route = '/interactChat';
  final HubMessageRepository chatRepository;
  final SessionRepository sessionRepository;

  InteractHubMessageBloc(
      {@required this.chatRepository, @required this.sessionRepository}) {
    listenOn<HubMessageForm>(_sendMessage);
  }

  @override
  Future<void> onEvent(InteractHubMessageEvent event) async {
    if (event is LoadChat) {
      await _loadBySelector(event.selector);
    } else if (event is SelectReaction) {
      await _applyReaction(event.reaction, event.messageChat);
    }
  }

  Future<void> _applyReaction(TypeReaction reaction, Message message) async {
    final hub = await _buildEntity();

    final session = await sessionRepository.load();
    final reactionOfUser =
        UserReaction(createdBy: session.user, reaction: reaction);

    bool exist = message.reactions.any((ru) =>
        ru.createdBy.email == session.user.email &&
        ru.reaction.selector == reaction.selector);

    if (exist) {
      await chatRepository.removeReaction(
          hub.selector, message.selector, reactionOfUser);
      message.reactions.remove(reactionOfUser);
    } else {
      await chatRepository.addReaction(
          hub.selector, message.selector, reactionOfUser);
      message.reactions.add(reactionOfUser);
    }

    //await chatRepository.save(hub);

    final hubReactionsCounted = await chatRepository.loadByKey(hub.selector);

    _updateHubOnScreen(hubReactionsCounted);
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await chatRepository.loadByKey(selector);
    dispatchOn(entity, key: HubMessageForm.chat);
  }

  Future<void> _sendMessage(HubMessageForm _) async {
    final hub = await _buildEntity();
    final message = await _buildMessage();

    hub.messageChat.add(message);

    _updateHubOnScreen(hub);
    _cleanTextMessage();

    await chatRepository.addMessage(hub.selector, message);
  }

  Future<Message> _buildMessage() async {
    final map = valuesToMap<HubMessageForm>();
    final session = await sessionRepository.load();

    return Message(
      createdBy: session.user,
      createdAt: DateTime.now(),
      status: "sending",
      selector: Uuid().v4(),
      // ignore: prefer_const_literals_to_create_immutables
      reactions: <UserReaction>{},
      text: map[HubMessageForm.textMessage] as String,
    );
  }

  Future<HubMessage> _buildEntity() async {
    final map = valuesToMap<HubMessageForm>();
    final hub = map[HubMessageForm.chat] as HubMessage;
    return hub;
  }

  void _updateHubOnScreen(HubMessage hub) {
    dispatchOn(hub, key: HubMessageForm.chat);
  }

  void _cleanTextMessage() {
    dispatchOn("", key: HubMessageForm.textMessage);
  }
}

enum HubMessageForm { actionSend, textMessage, chat }
