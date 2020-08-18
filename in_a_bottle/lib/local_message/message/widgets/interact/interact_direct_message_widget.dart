import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_event.dart';

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
    _bloc.dispatchOn<InteractEventDirectMessage>(
        InteractLoadDirectMessage(widget.selector));
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
          child: StreamBuilder<DirectMessage>(
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
