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
import 'package:in_a_bottle/local_message/reaction.dart';

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
        ...message.reactions
            .map<Widget>((reaction) => _buildReaction(reaction, message))
            .toList(),
        w.FlutterReactionButton(
          onReactionChanged: (reaction) {
            final reactionX = reaction as ReactionX;
            _bloc.dispatchOn<InteractChatEvent>(
                SelectReaction(Reaction(reaction: reactionX.url), message));
          },
          shouldChangeReaction: false,
          boxColor: Colors.black,
          reactions: <ReactionX>[
            ReactionX(
              url:
                  'https://lh3.google.com/u/1/ogw/ADGmqu8Cu89HRnDTSL2_XKXABmwoeL038BTA7_DPVDbs=s32-c-mo',
              id: 1,
              previewIcon: _buildPreviewIcon(
                'https://lh3.google.com/u/1/ogw/ADGmqu8Cu89HRnDTSL2_XKXABmwoeL038BTA7_DPVDbs=s32-c-mo',
              ),
              icon: _buildIcon(
                  'https://lh3.google.com/u/1/ogw/ADGmqu8Cu89HRnDTSL2_XKXABmwoeL038BTA7_DPVDbs=s32-c-mo'),
            ),
            ReactionX(
              url:
                  'https://lh3.googleusercontent.com/ogw/ADGmqu_0MXQKJj2LcjUSpFdxeshwTYbTLj8Ud705WzKC=s83-c-mo',
              id: 3,
              previewIcon: _buildPreviewIcon(
                'https://lh3.googleusercontent.com/ogw/ADGmqu_0MXQKJj2LcjUSpFdxeshwTYbTLj8Ud705WzKC=s83-c-mo',
              ),
              icon: _buildIcon(
                  'https://lh3.googleusercontent.com/ogw/ADGmqu_0MXQKJj2LcjUSpFdxeshwTYbTLj8Ud705WzKC=s83-c-mo'),
            ),
            ReactionX(
              url:
                  'https://lh3.google.com/u/2/ogw/ADGmqu8j08OCxlZTqkNOO2m8DSwmLgUGzfd6UlENNrt0=s32-c-mo',
              id: 4,
              previewIcon: _buildPreviewIcon(
                'https://lh3.google.com/u/2/ogw/ADGmqu8j08OCxlZTqkNOO2m8DSwmLgUGzfd6UlENNrt0=s32-c-mo',
              ),
              icon: _buildIcon(
                  'https://lh3.google.com/u/2/ogw/ADGmqu8j08OCxlZTqkNOO2m8DSwmLgUGzfd6UlENNrt0=s32-c-mo'),
            ),
          ],
          initialReaction: ReactionX(id: 0, icon: const Icon(Icons.add)),
        )
      ],
    ));
  }

  //https://pub.dev/packages/flutter_reaction_button
  Widget _buildReaction(Reaction reaction, MessageChat messageChat) {
    return Column(children: [
      GestureDetector(
        onTap: () => _bloc.dispatchOn<InteractChatEvent>(
            SelectReaction(reaction, messageChat)),
        child: _buildIcon(reaction.reaction),
      ),
      Text(reaction.amount.toString()),
    ]);
  }

  Widget _buildIcon(String imageUrl) => Image.network(
        imageUrl,
        height: 30,
        width: 30,
      );

  Widget _buildPreviewIcon(String imageUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Image.network(imageUrl, height: 30),
      );
}

class ReactionX extends w.Reaction {
  final String url;

  ReactionX(
      {this.url, int id, Widget icon, Widget previewIcon, bool enabled = true})
      : super(id: id, icon: icon, previewIcon: previewIcon, enabled: enabled);
}
