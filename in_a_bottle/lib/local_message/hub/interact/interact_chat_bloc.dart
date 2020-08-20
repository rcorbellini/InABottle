import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/message_chat.dart';
import 'package:in_a_bottle/local_message/reaction.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/hub/chat_repository.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_chat_event.dart';

class InteractChatBloc extends BaseBloc<InteractChatEvent> {
  static const String route = '/interactChat';
  final ChatRepository chatRepository;
  final SessionRepository sessionRepository;

  InteractChatBloc(
      {@required this.chatRepository, @required this.sessionRepository}) {
    listenOn<HubMessageForm>(_sendMessage);
  }

  @override
  Future<void> onEvent(InteractChatEvent event) async {
    if (event is LoadChat) {
      await _loadBySelector(event.selector);
    } else if (event is SelectReaction) {
      await _applyReaction(event.reaction, event.messageChat);
    }
  }

  Future<void> _applyReaction(Reaction reaction, MessageChat message) async {
    final hub = await _buildEntity();

    final session = await sessionRepository.load();
    final reactionOfUser = reaction.copyWith(createdBy: session.user);

    bool exist = message.reactions.contains(reactionOfUser);

    if (exist) {
      message.reactions.remove(reactionOfUser);
    } else {
      message.reactions.add(reactionOfUser);
    }

    await chatRepository.save(hub);

    final hubReactionsCounted = await chatRepository.loadByKey("key");

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

    await chatRepository.save(hub);
  }

  Future<MessageChat> _buildMessage() async {
    final map = valuesToMap<HubMessageForm>();
    final session = await sessionRepository.load();

    return MessageChat(
      user: session.user,
      createdAt: DateTime.now(),
      status: "sending",
      // ignore: prefer_const_literals_to_create_immutables
      reactions: <Reaction>{},
      text: map[HubMessageForm.textMessage] as String,
    );
  }

  Future<Chat> _buildEntity() async {
    final map = valuesToMap<HubMessageForm>();
    final hub = map[HubMessageForm.chat] as Chat;
    return hub;
  }

  void _updateHubOnScreen(Chat hub) {
    dispatchOn(hub, key: HubMessageForm.chat);
  }

  void _cleanTextMessage() {
    dispatchOn("", key: HubMessageForm.textMessage);
  }
}

enum HubMessageForm { actionSend, textMessage, chat }
