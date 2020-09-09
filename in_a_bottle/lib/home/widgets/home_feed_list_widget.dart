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
    return StreamBuilder<List<HomeFeed>>(
        stream: homeBloc.streamOf<List<HomeFeed>>(), builder: _builFeedList);
  }

  Widget _builFeedList(
      BuildContext context, AsyncSnapshot<List<HomeFeed>> snapshot) {
    final feed = snapshot.data;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildItem(feed[index]);
        },
        childCount: snapshot.hasData ? feed.length : 0,
      ),
    );
  }

  Widget _buildItem(HomeFeed item) {
    if (item is DirectMessage) {
      return Stack(
        children: [
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 32.0,
            child: Container(
              height: double.infinity,
              width: 1.0,
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            top: 45.0,
            left: 30,
            right: 20,
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            top: 20.0,
            left: 8.0,
            child: new Container(
              height: 50.0,
              width: 50.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: new Container(
                margin: new EdgeInsets.all(5.0),
                height: 50.0,
                width: 50.0,
                child: buildAvatar(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(60, 4, 8, 4),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 0.4,
                shadowColor: Colors.orange,
                child: Container(
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
                            InteractDirectMessageBloc.route,
                            params: <String, dynamic>{
                              "selector": item.selector
                            })),
                        child: Container(
                          margin: EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.message.title ?? '--',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    item.createdOn.isLocked &&
                                            item.createdOn.isPrivateDM
                                        ? Image.asset(
                                            'assets/images/locked.png',
                                            height: 50,
                                            width: 50,
                                          )
                                        : Text(
                                            item.message.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      );
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
                          item.createdOn.contentLock ? 'Locked' : item.title,
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

  Widget buildAvatar() {
    return Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/a-/AOh14GjcZr7Td-GC9joDcnbnimnc41KvfAgQ9oVrBFYj=s96-c-rg-br100"),
        ),
        Positioned(
          bottom: -30,
          child: Container(
            width: 40.0,
            height: 40.0,
            child: Center(
              child: Text('100'),
            ),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/coin-points.png'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
