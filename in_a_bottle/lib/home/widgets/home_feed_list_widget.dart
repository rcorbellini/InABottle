import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
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
            left: 40.0,
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
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      height: 60.0,
                      width: 60.0,
                      child: buildAvatar(item),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        getDifferenceBetweenDates(item.createdAt),
                        style: Theme.of(context).textTheme.subtitle1,
                      ))
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(80, 4, 8, 4),
              child: Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0.5,
                    child: GestureDetector(
                      onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
                          InteractDirectMessageBloc.route,
                          params: <String, dynamic>{
                            "selector": item.selector
                          })),
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              item.message.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Expanded(
                                child: item.createdOn.isLocked &&
                                        item.createdOn.isPrivateDM
                                    ? Container()
                                    : Text(
                                        item.message.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Pessoas Reagiram (${item?.message?.reactions?.length ?? 0})",
                                  style: Theme.of(context).textTheme.overline,
                                ),
                                buildAvatarsReactions(
                                    item?.message?.reactions?.toList() ?? [])
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  item.createdOn.isLocked && item.createdOn.isPrivateDM
                      ? buildLockFlag()
                      : Container(),
                  item.message.reactions.isNotEmpty
                      ? buildHuntFlag()
                      : Container()
                ],
              )),
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

  Widget buildLockFlag() {
    return buildFlag(
        Icon(
          Icons.lock,
          color: Colors.white,
        ),
        Container(),
        Colors.grey[800]);
  }

  Widget buildHuntFlag() {
    return buildFlag(
        Icon(
          Icons.map,
          color: Colors.white,
        ),
         Text(
              "1/2",
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        Colors.brown[700]);
  }

  Widget buildFlag(Widget iconflag, Widget contentFlag, Color background) {
    return Positioned(
      right: 20,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: 30.0,
            height: 90.0,
            color: background,
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
                child: contentFlag),
          ),
          Positioned(bottom: 20, left: 3, child: iconflag),
          Positioned(
              bottom: -20,
              left: -5,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }

  Widget buildAvatarsReactions(List<UserReaction> reacao) {
    if (reacao.isEmpty) {
      return Container(width: 60);
    }
    return Container(
        width: 100,
        padding: EdgeInsets.only(left: 8),
        child: Stack(
            overflow: Overflow.clip,
            children: reacao
                .asMap()
                .map((key, value) => MapEntry(
                    key,
                    key == 0
                        ? buildAvatarReaction(value)
                        : Positioned(
                            left: key * 10.0,
                            child: buildAvatarReaction(value))))
                .values
                .toList()));
  }

  Widget buildAvatarReaction(UserReaction reacao) {
    return CircleAvatar(
      radius: 10,
      backgroundImage: NetworkImage(reacao.createdBy?.photoUrl ??
          "https://lh3.googleusercontent.com/a-/AOh14GjcZr7Td-GC9joDcnbnimnc41KvfAgQ9oVrBFYj=s96-c-rg-br100"),
    );
  }

  Widget buildAvatar(BaseModel item) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/a-/AOh14GjcZr7Td-GC9joDcnbnimnc41KvfAgQ9oVrBFYj=s96-c-rg-br100"),
        ),
        Positioned(
          bottom: -10,
          right: -5,
          child: Container(
            width: 33.0,
            height: 33.0,
            child: Center(
              child: Text(
                item.createdBy?.points?.toString() ?? "100",
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.withOpacity(0.95),
                border: Border.all(color: Colors.white, width: 3)),
          ),
        )
      ],
    );
  }
}

String getDifferenceBetweenDates(DateTime date) {
  if (date == null) {
    return "";
  }
  var duration = DateTime.now().toLocal().difference(date.toLocal());

  var days = duration.inDays;
  if (days > 0) {
    return "${days}d";
  }

  var hours = duration.inHours.remainder(24);
  if (hours > 0) {
    return "${hours}h";
  }

  var minutes = duration.inMinutes.remainder(60);
  if (minutes > 0) {
    return "${minutes}m";
  }

  var seconds = duration.inSeconds.remainder(60);
  if (seconds > 0) {
    return "${seconds}s";
  }

  return "";
}
