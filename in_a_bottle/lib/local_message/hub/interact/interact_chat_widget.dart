import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart' as w;
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/form_factory.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_button.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_chat_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_chat_event.dart';
import 'package:in_a_bottle/local_message/hub/message_chat.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/reaction/reaction_widget.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

class InteractChatWidget extends StatefulWidget {
  final String selector;

  const InteractChatWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractChatWidgetState createState() => _InteractChatWidgetState();
}

class _InteractChatWidgetState extends State<InteractChatWidget> {
  InteractChatBloc _bloc;
  FormFactory<HubMessageForm> _formFactory;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.dispatchOn<InteractChatEvent>(LoadChat(widget.selector));
    _formFactory = FormFactory<HubMessageForm>(context: context, bloc: _bloc);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder<Chat>(
              stream: _bloc.streamOf(key: HubMessageForm.chat),
              builder: (context, snpashot) {
                final hub = snpashot.data;
                return LockWidget(
                  local: hub?.local,
                  child: _content(hub),
                );
              })),
    );
  }

  Widget _content(Chat hub) {
    return Column(
        children: [_buildHubMessages(hub?.messageChat), _formMessage()]);
  }

  Widget _formMessage() {
    return Column(children: [
      _formFactory.build(HubMessageForm.textMessage),
      _formFactory.build(HubMessageForm.actionSend)
    ]);
  }

  Widget _buildHubMessages(List<MessageChat> msgs) {
    if (msgs == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: msgs.map(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(MessageChat message) {
    return Container(
        child: Column(
      children: [
        Text(message.text),
        ReactionWidget(
          onReactionChange: (typeReaction) =>
              _bloc.dispatchOn<InteractChatEvent>(
                  SelectReaction(typeReaction, message)),
          userReactions: message.reactions,
        )
      ],
    ));
  }

}
