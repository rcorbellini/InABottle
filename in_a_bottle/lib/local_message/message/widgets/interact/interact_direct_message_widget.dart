import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:in_a_bottle/local_message/chat/chat.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_chat_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_event.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';

class InteractChatWidget extends StatefulWidget {
  final String selector;

  const InteractChatWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractChatWidgetState createState() => _InteractChatWidgetState();
}

class _InteractChatWidgetState extends State<InteractChatWidget> {
  InteractChatBloc _bloc;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.dispatchOn<InteractEvent>(InteractLoadChat(widget.selector));
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
              stream: _bloc.streamOf(),
              builder: (context, snpashot) {
                return LockWidget(
                  local: snpashot.data?.local,
                  child: Text("msg aqui"),
                );
              })),
    );
  }
}
