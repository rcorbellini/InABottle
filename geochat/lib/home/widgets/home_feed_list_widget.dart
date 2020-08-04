import 'package:flutter/material.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/home/home_feed.dart';
import 'package:geochat/local_message/message/direct_message_dto.dart';
import 'package:geochat/local_message/talk/talk_dto.dart';
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
      final talks = snapshot.data;
      return ListView(
        children: talks.map(_buildTalkItem).toList(),
      );
    }

    return const CircularProgressIndicator();
  }

  Widget _buildTalkItem(HomeFeed item) {
    if (item is DirectMessage) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(16.0))),
                padding: const EdgeInsets.all(16),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        item.text,
                        style: Theme.of(context).textTheme.body1,
                      )
                    ])),
            Container(
                margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Text("@${item.owner?.name ?? '--'}"))
          ]);
    }
    return Container();
  }
}
