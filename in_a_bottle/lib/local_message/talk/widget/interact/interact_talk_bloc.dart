import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_event.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';

class InteractTalkBloc extends BaseBloc<InteractTalkEvent> {
  static const String route = '/interactTalk';
  final TalkRepository talkRepository;
  final SessionRepository sessionRepository;

  InteractTalkBloc({
    @required this.talkRepository,
    @required this.sessionRepository,
  }) {
    listenOn<InteractTalkForm>(_sendMessage);
  }

  @override
  Future<void> onEvent(InteractTalkEvent event) async {
    if (event is LoadTalk) {
      await _loadBySelector(event.selector);
    }else if(event is SelectReaction){
       await _applyReaction(event.reaction, event.message);
    }
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

    await talkRepository.save(entity);

    final hubReactionsCounted = await talkRepository.loadByKey("key");

    setState(hubReactionsCounted);
  }

  Future<void> _loadBySelector(String selector) async {
    final entity = await talkRepository.loadByKey(selector);
    dispatchOn(entity, key: InteractTalkForm.talk);
  }

  Future<void> _sendMessage(InteractTalkForm _) async {
    final entity = await _buildEntity();
    final message = await _buildMessage();

    final map = valuesToMap<InteractTalkForm>();

    final tabIndex = map[InteractTalkForm.tabIndex];
    if (tabIndex == 1) {
      entity.openMessage.add(message);
    } else {
      entity.closeMessage.add(message);
    }

    setState(entity);
    _cleanTextMessage();

    await talkRepository.save(entity);
  }

  void setState(Talk entity) {
    dispatchOn(entity, key: InteractTalkForm.talk);
  }

  Future<Talk> _buildEntity() async {
    final map = valuesToMap<InteractTalkForm>();

    return map[InteractTalkForm.talk];
  }

  void _cleanTextMessage() {
    dispatchOn("", key: InteractTalkForm.textMessage);
  }

  Future<Message> _buildMessage() async {
    final map = valuesToMap<InteractTalkForm>();
    final session = await sessionRepository.load();

    return Message(
      //user: session.user,
      //createdAt: DateTime.now(),
      //status: "sending",
      reactions: <UserReaction>{},
      text: map[InteractTalkForm.textMessage] as String,
    );
  }
}

enum InteractTalkForm { talk, textMessage, actionSend, tabIndex }
