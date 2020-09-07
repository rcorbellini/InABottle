import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_event.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/reaction_widget.dart';

class InteractHubMessageWidget extends StatefulWidget {
  final String selector;

  const InteractHubMessageWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractHubMessageWidgetState createState() =>
      _InteractHubMessageWidgetState();
}

class _InteractHubMessageWidgetState extends State<InteractHubMessageWidget> {
  InteractHubMessageBloc _bloc;
  FormFactory<HubMessageForm> _formFactory;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.dispatchOn<InteractHubMessageEvent>(LoadChat(widget.selector));
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
          child: StreamBuilder<HubMessage>(
              stream: _bloc.streamOf(key: HubMessageForm.chat),
              builder: (context, snpashot) {
                final hub = snpashot.data;
                return LockWidget(
                  local: hub?.createdOn,
                  child: _content(hub),
                );
              })),
    );
  }

  Widget _content(HubMessage hub) {
    return Column(
        children: [_buildHubMessages(hub?.messageChat), _formMessage()]);
  }

  Widget _formMessage() {
    return Column(children: [
      _formFactory.build(HubMessageForm.textMessage),
      _formFactory.build(HubMessageForm.actionSend)
    ]);
  }

  Widget _buildHubMessages(List<Message> msgs) {
    if (msgs == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: msgs.map(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(Message message) {
    return Container(
        child: Column(
      children: [
        Text(message.text),
        ReactionWidget(
          onReactionChange: (typeReaction) =>
              _bloc.dispatchOn<InteractHubMessageEvent>(
                  SelectReaction(typeReaction, message)),
          userReactions: message.reactions,
        )
      ],
    ));
  }
}
