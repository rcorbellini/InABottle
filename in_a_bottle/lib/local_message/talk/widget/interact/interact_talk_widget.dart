import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/talk/talk_model.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_event.dart';

class InteractTalkWidget extends StatefulWidget {
  final String selector;

  const InteractTalkWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractTalkWidgetState createState() =>
      _InteractTalkWidgetState();
}

class _InteractTalkWidgetState
    extends State<InteractTalkWidget> {
  InteractTalkBloc _bloc;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.dispatchOn<InteractTalkEvent>(LoadTalk(widget.selector));
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
          child: StreamBuilder<Talk>(
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
