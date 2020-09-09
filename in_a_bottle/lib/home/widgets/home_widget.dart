import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_feed_list_widget.dart';
import 'package:in_a_bottle/home/widgets/home_talk_list_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/home/widgets/home_treasure_hunt_list_widget.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/create/create_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/treasure_hunt_bloc.dart';
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0x102BC0E4), Color(0x33EAECC6)])),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0x052BC0E4),
              expandedHeight: 100.0,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(background: Text("InABottle")),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              HomeTalkListWidget(
                homeBloc: _homeBloc,
                context: context,
              ),
              HomeTreasureHuntListWidget(
                homeBloc: _homeBloc,
                context: context,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Feed",
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ])),
            HomeFeedList(
              homeBloc: _homeBloc,
              context: context,
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
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

          return Text(snapshot.data?.user?.photoUrl ?? '-|-');
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
          HomeTreasureHuntListWidget(
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
            child: const Text("Talk"),
            onPressed: () {
              _homeBloc.dispatchOn<HomeEvent>(GoToRoute(TalkBloc.route));
            },
          ),
          FlatButton(
            child: const Text("Chat"),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(CreateHubMessageBloc.route));
            },
          ),
          FlatButton(
            child: const Text("Item"),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(DirectMessageBloc.route));
            },
          ),
          FlatButton(
            child: const Text("Caça"),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(TreasureHuntBloc.route));
            },
          ),
        ],
      ),
    );
  }
}
