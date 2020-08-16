import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/home/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_feed_list_widget.dart';
import 'package:in_a_bottle/home/widgets/home_talk_list_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/chat/create/create_chat_bloc.dart';
import 'package:in_a_bottle/local_message/message/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/talk/talk_bloc.dart';
import 'package:in_a_bottle/session/session_dto.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = Injector().get<HomeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [_buildHeader(), _buildContent(), _buildFooter()]));
  }

  //Footer
  //TODO fazer
  Widget _buildHeader() {
    return Container(
      height: 58,
      color: Colors.grey,
      child: StreamBuilder<Session>(
        stream: _homeBloc.streamOf(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("--1212");
          }

          return Text(snapshot.data.user.photoUrl);
        },
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HomeTalkListWidget(
            homeBloc: _homeBloc,
            context: context,
          ),
          Expanded(
              child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                HomeFeedList(
                  homeBloc: _homeBloc,
                  context: context,
                ),
                RaisedButton(
                  child: const Text("Mapa"),
                  onPressed: () {
                    _homeBloc.dispatchOn<HomeEvent>(GoToRoute("/map"));
                  },
                ),
              ]))
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: const Text("Adicionar Talk"),
            onPressed: () {
              _homeBloc.dispatchOn<HomeEvent>(GoToRoute(TalkBloc.route));
            },
          ),
          FlatButton(
            child: const Text("Adicionar Chat"),
            onPressed: () {
              _homeBloc.dispatchOn<HomeEvent>(GoToRoute(CreateChatBloc.route));
            },
          ),
          FlatButton(
            child: const Text("Adicionar Item"),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(DirectMessageBloc.route));
            },
          ),
        ],
      ),
    );
  }
}
