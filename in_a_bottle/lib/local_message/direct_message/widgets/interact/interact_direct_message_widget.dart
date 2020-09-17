import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_event.dart';
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
    return SafeArea(
      child: Material(
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              height: 400,
              padding: EdgeInsets.only(top: 16),
              child: StreamBuilder<DirectMessage>(
                  stream: _bloc.streamOf<DirectMessage>(
                      key: DirectMessageForm.directMessage),
                  builder: (context, snpashot) {
                    if (!snpashot.hasData) {
                      return Container();
                    }
                    final dm = snpashot.data;
                    return LockWidget(
                      local: dm?.createdOn,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                  child: Container(
                                width: 46,
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[700]),
                              )),
                              Row(
                                children: [
                                  AvatarTimeLine(
                                    user: dm.createdBy,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      child: Text(
                                        dm.message.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(child: Icon(Icons.close)),
                                  )
                                ],
                              ),
                              Divider(),
                                Bubble(
                                  margin: BubbleEdges.only(
                                      top: 10, left: 24, bottom: 8),
                                  nip: BubbleNip.leftTop,
                                  nipWidth: 8,
                                  nipHeight: 8,
                                  color: Colors.black,
                                  child: Text(
                                    dm.message.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: Colors.white),
                                  ),
                                ), 
                                Padding(
                                  padding: EdgeInsets.only(left:24),
                                  child: 
                                ReactionWidget(
                                    onReactionChange: (r) => _bloc
                                        .dispatchOn<InteractDirectMessageEvent>(
                                            SelectReaction(r, dm)),
                                    userReactions: dm?.message?.reactions,
                                  ),
                                ),
                            ],),
                      ),
                    );
                  }))),
    );
  }
}
