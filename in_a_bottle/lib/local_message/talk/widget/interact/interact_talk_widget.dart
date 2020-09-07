import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/reaction_widget.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_event.dart';

class InteractTalkWidget extends StatefulWidget {
  final String selector;

  const InteractTalkWidget({Key key, this.selector}) : super(key: key);
  @override
  _InteractTalkWidgetState createState() => _InteractTalkWidgetState();
}

class _InteractTalkWidgetState extends State<InteractTalkWidget>
    with SingleTickerProviderStateMixin {
  InteractTalkBloc _bloc;
  FormFactory _formFactory;
  TabController _tabController;
  @override
  void initState() {
    _bloc = Injector().get();
    _formFactory = FormFactory<InteractTalkForm>(bloc: _bloc, context: context);
    _bloc.dispatchOn<InteractTalkEvent>(LoadTalk(widget.selector));
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      _bloc.dispatchOn<int>(_tabController.index,
          key: InteractTalkForm.tabIndex);
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<Talk>(
            stream: _bloc.streamOf(key: InteractTalkForm.talk),
            builder: (context, snpashot) {
              final talk = snpashot.data;
              if (talk == null) {
                return Container();
              }
              return LockWidget(
                local: talk?.local,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(icon: Icon(Icons.lock)),
                        Tab(icon: Icon(Icons.lock_open)),
                      ],
                    ),
                    title: Text('Talk'),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: talk.closeMessage
                                  .map(_buildItemMessage)
                                  .toList(),
                            ),
                            Column(
                              children: talk.openMessage
                                  .map(_buildItemMessage)
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      _formMessage()
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _formMessage() {
    return Column(children: [
      _formFactory.build(InteractTalkForm.textMessage),
      _formFactory.build(InteractTalkForm.actionSend)
    ]);
  }

  Widget _buildItemMessage(Message talkMessage) {
    return Container(
        child: Column(
      children: [
        Text(talkMessage.text),
        ReactionWidget(
          onReactionChange: (typeReaction) =>
              _bloc.dispatchOn<InteractTalkEvent>(
                  SelectReaction(typeReaction, talkMessage)),
          userReactions: talkMessage.reactions,
        )
      ],
    ));
  }
}
