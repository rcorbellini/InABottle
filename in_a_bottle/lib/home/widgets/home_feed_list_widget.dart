import 'package:flutter/material.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:meta/meta.dart';

class HomeFeedList extends StatelessWidget {
  final HomeBloc homeBloc;
  final BuildContext context;

  const HomeFeedList({@required this.homeBloc, @required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Feed",
              style: Theme.of(context).textTheme.display1,
            ),
            Expanded(
                child: StreamBuilder<List<HomeFeed>>(
                    stream: homeBloc.streamOf<List<HomeFeed>>(),
                    builder: _builFeedList))
          ],
        ));
  }

  Widget _builFeedList(
      BuildContext context, AsyncSnapshot<List<HomeFeed>> snapshot) {
    if (snapshot.hasData) {
      final feed = snapshot.data;
      return ListView(
        children: feed.map(_buildItem).toList(),
      );
    }

    return const CircularProgressIndicator();
  }

  Widget _buildItem(HomeFeed item) {
    if (item is DirectMessage) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
                  InteractDirectMessageBloc.route,
                  params: <String, dynamic>{"selector": item.selector})),
              child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.message.title ?? '--',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          item.local.isLocked
                              ? 'Locked'
                              : item.message.text ?? '--',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ])),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Text("@${item.message.createdBy?.name ?? '--'}"))
          ]);
    } else if (item is HubMessage) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
                  InteractHubMessageBloc.route,
                  params: <String, dynamic>{"selector": item.selector})),
              child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          item.local.contentLock ? 'Locked' : item.title,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ])),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Text("@${item.createdBy?.name ?? '--'}"))
          ]);
    }
    return Container();
  }
}
