import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_feed_list_widget.dart';
import 'package:in_a_bottle/home/widgets/home_talk_list_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/home/widgets/home_treasure_hunt_list_widget.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/create/create_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/treasure_hunt_bloc.dart';

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
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0x102BC0E4), Color(0x50EAECC6)])),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.black.withOpacity(0),
                elevation: 1,
                floating: false,
                pinned: false,
                title: Text(
                  "In A Bottle",
                  style: Theme.of(context)
                      .textTheme
                      .headline4,
                ),
                actions: [
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: AvatarTimeLine(user: null))
                ],
              ),

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
      floatingActionButton: new FloatingActionButton.extended(
        icon: Icon(Icons.map),
        label: Text('Mapa'),
        backgroundColor: Color(0xbbEAECC6),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      bottomNavigationBar: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

class _MyAppSpace extends StatelessWidget {
  const _MyAppSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            Center(
              child: Opacity(
                  opacity: 1 - opacity,
                  child: getTitle(
                    'Collapsed Title',
                  )),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getImage(),
                  getTitle(
                    'Expended Title',
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getImage() {
    return Container(
      width: double.infinity,
      child: Image.network(
        'https://source.unsplash.com/daily?code',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget getTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
