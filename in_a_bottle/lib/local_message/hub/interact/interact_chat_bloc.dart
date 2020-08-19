import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/message_chat.dart';
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
    }
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await chatRepository.loadByKey(selector);
    dispatchOn(entity, key: HubMessageForm.chat);
  }

  Future<void> _sendMessage(HubMessageForm _) async {
    final map = valuesToMap<HubMessageForm>();
    final hub = map[HubMessageForm.chat] as Chat;
    final session = await sessionRepository.load();
    hub.messageChat.add(MessageChat(
      user: session.user,
      createdAt: DateTime.now(),
      status: "sending",
      text: map[HubMessageForm.textMessage] as String,
    ));

    _updateUbOnScreen(hub);
    _cleanMessageText();

    await chatRepository.save(hub);
  }

  void _updateUbOnScreen(Chat hub){
    dispatchOn(hub, key: HubMessageForm.chat);
  }

  void _cleanMessageText(){
    dispatchOn("", key: HubMessageForm.textMessage);
  }
}

enum HubMessageForm { actionSend, textMessage, chat }
