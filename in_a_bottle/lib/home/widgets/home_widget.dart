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
                  colors: [Color(0x102BC0E4), Color(0x50EAECC6)])),
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Color(0x052BC0E4),
                    expandedHeight: 100.0,
                    floating: true,
                    pinned: false,
                    flexibleSpace:
                        FlexibleSpaceBar(background: Text("InABottle")),
                  )
                ];
              },
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildListDelegate([

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Talks",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    HomeTalkListWidget(
                      homeBloc: _homeBloc,
                      context: context,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Caçadas",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    HomeTreasureHuntListWidget(
                      homeBloc: _homeBloc,
                      context: context,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Por Perto",
                        style: Theme.of(context).textTheme.headline4,
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
          )),
      bottomNavigationBar: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.people),
                Text(
                  "Talk",
                  style: Theme.of(context).textTheme.overline,
                )
              ],
            ),
            onPressed: () {
              _homeBloc.dispatchOn<HomeEvent>(GoToRoute(TalkBloc.route));
            },
          ),
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.chat),
                Text(
                  "Chat",
                  style: Theme.of(context).textTheme.overline,
                )
              ],
            ),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(CreateHubMessageBloc.route));
            },
          ),
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.textsms),
                Text(
                  "Message",
                  style: Theme.of(context).textTheme.overline,
                )
              ],
            ),
            onPressed: () {
              _homeBloc
                  .dispatchOn<HomeEvent>(GoToRoute(DirectMessageBloc.route));
            },
          ),
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.map),
                Text(
                  "Caçada",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.overline,
                )
              ],
            ),
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
