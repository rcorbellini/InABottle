import 'package:bubble/bubble.dart';
import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/common/widget/locked/lock_widget.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_event.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/reaction_widget.dart';
import 'package:random_color/random_color.dart';

class InteractHubMessageWidget extends StatefulWidget {
  final String selector;
  final ScrollController scrollController;

  const InteractHubMessageWidget(
      {Key key, this.selector, this.scrollController})
      : super(key: key);
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
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          padding: EdgeInsets.only(top: 16),
          child: StreamBuilder<HubMessage>(
            stream: _bloc.streamOf(key: HubMessageForm.chat),
            builder: (context, snpashot) {
              if (!snpashot.hasData) {
                return Container();
              }
              final hub = snpashot.data;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      width: 46,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[700]),
                    )),
                    Row(
                      children: [
                        AvatarTimeLine(
                          user: hub.createdBy,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              hub.title,
                              style: Theme.of(context).textTheme.headline5,
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
                    Expanded(
                        child: LockWidget(
                            local: hub?.createdOn,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildHubMessages(hub?.messageChat),
                                  _formMessage()
                                ])))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _formMessage() {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[100]),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _formFactory.build(HubMessageForm.textMessage),
              )),
              _formFactory.build(HubMessageForm.actionSend)
            ]));
  }

  Widget _buildHubMessages(List<Message> msgs) {
    if (msgs == null) {
      return Container();
    }
    return Expanded(
        child: ListView(
      controller: widget.scrollController,
      children: msgs.map(buildItem).toList(),
    ));
  }

  Widget buildItem(Message message) {
    return ItemHubMessage(
      message: message,
      bloc: _bloc,
    );
  }
}

class ItemHubMessage extends StatelessWidget {
  final BaseBloc bloc;
  final Message message;

  const ItemHubMessage({Key key, this.bloc, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
          AvatarTimeLine(
            user: message.createdBy,
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10, left: 8, bottom: 8),
            nip: BubbleNip.leftTop,
            nipWidth: 8,
            nipHeight: 8,
            color: RandomColor().randomColor(
                colorBrightness: ColorBrightness.veryDark,
                colorSaturation: ColorSaturation.highSaturation,
                colorHue: ColorHue.multiple(
                    colorHues: [ColorHue.red, ColorHue.blue])),
            child: Text(
              message.text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          )
        ]),
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: ReactionWidget(
            onReactionChange: (r) => bloc.dispatchOn<InteractHubMessageEvent>(
                SelectReaction(r, message)),
            userReactions: message?.reactions,
          ),
        ),
      ],
    ));
  }
}
