import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_event.dart';
import 'package:in_a_bottle/local_message/reaction/reaction_widget.dart';

class InteractDirectMessageWidget extends StatefulWidget {
  final String selector;

  const InteractDirectMessageWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractDirectMessageWidgetState createState() =>
      _InteractDirectMessageWidgetState();
}

class _InteractDirectMessageWidgetState
    extends State<InteractDirectMessageWidget> {
  InteractDirectMessageBloc _bloc;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.dispatchOn<InteractDirectMessageEvent>(
        LoadDirectMessage(widget.selector));
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
          child: StreamBuilder<Message>(
              stream: _bloc.streamOf<Message>(
                  key: DirectMessageForm.directMessage),
              builder: (context, snpashot) {
                final dm = snpashot.data;
                return LockWidget(
                  local: dm?.local,
                  child: Column(children: [
                    Text("msg aqui"),
                    ReactionWidget(
                      onReactionChange: (r) =>
                          _bloc.dispatchOn<InteractDirectMessageEvent>(
                              SelectReaction(r, dm)),
                      userReactions: dm?.reactions,
                    )
                  ]),
                );
              })),
    );
  }
}
