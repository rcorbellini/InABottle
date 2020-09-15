import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/loading_indicator.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user.dart';
import 'package:meta/meta.dart';
import 'package:in_a_bottle/_shared/extesions/datetime_ext.dart';

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
    if (snapshot.hasData) {
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

    return   SliverList(
                  delegate: SliverChildListDelegate([LoadingIndicator()]));
  }

  Widget _buildItem(HomeFeed item) {
    if (item is DirectMessage) {
      return CardFeedDirectMessage(
        directMessage: item,
        onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
            InteractDirectMessageBloc.route,
            params: <String, dynamic>{"selector": item.selector})),
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
}

class CardFeedDirectMessage extends StatelessWidget {
  final DirectMessage directMessage;
  final GestureTapCallback onTap;

  const CardFeedDirectMessage({Key key, this.directMessage, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 40.0,
          child: Container(
            height: double.infinity,
            width: 1.2,
            color: Colors.grey.shade300,
          ),
        ),
        Positioned(
          top: 45.0,
          left: 30,
          right: 20,
          child: Container(
            height: 1.2,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ),
        Positioned(
            top: 20.0,
            left: 8.0,
            child: Column(
              children: [
                AvatarTimeLine(user: directMessage.createdBy),
                Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      directMessage.createdAt.toTimeAgo(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ))
              ],
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(80, 4, 8, 4),
            child: Stack(
              children: [
                Cards.timeLine(
                  onTap: onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        directMessage.message.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                          child: directMessage.createdOn.isLocked &&
                                  directMessage.createdOn.isPrivateDM
                              ? Container()
                              : Text(
                                  directMessage.message.text,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Pessoas Reagiram (${directMessage?.message?.reactions?.length ?? 0})",
                            style: Theme.of(context).textTheme.overline,
                          ),
                          AvatarsReactions(
                              reactions:
                                  directMessage?.message?.reactions?.toList())
                        ],
                      )
                    ],
                  ),
                ),
                directMessage.createdOn.isLocked &&
                        directMessage.createdOn.isPrivateDM
                    ? FlagsOverflow.lock()
                    : Container(),
                directMessage.message.reactions.isNotEmpty
                    ? FlagsOverflow.treasureHunt(context, "1/2")
                    : Container()
              ],
            )),
      ],
    );
  }
}

///build deixar dinamico
///os parametros de posicao
class FlagsOverflow extends StatelessWidget {
  final Widget iconflag;
  final Widget contentFlag;
  final Color background;

  const FlagsOverflow(
      {Key key, this.iconflag, this.contentFlag, this.background})
      : super(key: key);

  FlagsOverflow.lock()
      : iconflag = Icon(
          Icons.lock,
          color: Colors.white,
        ),
        contentFlag = Container(),
        background = Colors.grey[800];

  FlagsOverflow.treasureHunt(BuildContext context, String content)
      : iconflag = Icon(
          Icons.map,
          color: Colors.white,
        ),
        contentFlag = Text(
          content,
          style: Theme.of(context)
              .textTheme
              .overline
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        background = Colors.brown[800];

  @override
  Widget build(BuildContext context) {
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
            child: Center(child: contentFlag),
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
}

class AvatarsReactions extends StatelessWidget {
  final List<UserReaction> reactions;

  const AvatarsReactions({Key key, this.reactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reactions?.isEmpty ?? true) {
      return Container(width: 60);
    }
    return Container(
        width: 100,
        padding: EdgeInsets.only(left: 8),
        child: Stack(
            overflow: Overflow.clip,
            children: reactions
                .asMap()
                .map((key, value) => MapEntry(
                    key,
                    key == 0
                        ? Avatars.small(value.createdBy?.photoUrl)
                        : Positioned(
                            left: key * 10.0,
                            child: Avatars.small(value.createdBy?.photoUrl))))
                .values
                .toList()));
  }
}

class AvatarTimeLine extends StatelessWidget {
  final User user;
  const AvatarTimeLine({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
            margin: EdgeInsets.all(3.0),
            height: 60.0,
            width: 60.0,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Avatars.big(user?.photoUrl),
                Positioned(
                  bottom: -10,
                  right: -5,
                  child: Coin(points: user?.points),
                )
              ],
            )));
  }
}

class Coin extends StatelessWidget {
  final int points;
  final double height;
  final double width;

  const Coin({Key key, this.points, this.width = 35, this.height = 35})
      : super(key: key);

  Coin.small(int points)
      : this.points = points,
        this.width = 25,
        this.height = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Stack(alignment: Alignment.center, children: [
          Image.asset(
            "assets/images/coin.png",
          ),
          Text(
            points?.toString() ?? "1k",
            style: Theme.of(context)
                .textTheme
                .overline
                .copyWith(fontWeight: FontWeight.bold),
          )
        ]),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber.withOpacity(0.95),
          border: Border.all(color: Colors.white, width: 3)),
    );
  }
}
