import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/bloc/home_bloc.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/bloc/home_event.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/home_feed.dart';
import 'package:meta/meta.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/extesions/datetime_ext.dart';
import 'package:in_a_bottle/_shared/widgets/loading_indicator.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:in_a_bottle/user/user.dart';

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

    return SliverList(delegate: SliverChildListDelegate([LoadingIndicator()]));
  }

  Widget _buildItem(HomeFeed item) {
    if (item is Talk) {
      return CardFeedTalk(
          talk: item,
          onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
              InteractTalkBloc.route,
              params: {"selector": item.selector})));
    } else if (item is DirectMessage) {
      return CardFeedDirectMessage(
        directMessage: item,
        onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
            InteractDirectMessageBloc.route,
            params: <String, dynamic>{"selector": item.selector})),
      );
    } else if (item is HubMessage) {
      return CardFeedHub(
        onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
            InteractHubMessageBloc.route,
            params: <String, dynamic>{"selector": item.selector})),
        hubMessage: item,
      );
    }
    return Container();
  }
}

class CardFeed extends StatelessWidget {
  final Widget child;
  final BaseModel baseModel;

  const CardFeed({
    Key key,
    this.child,
    this.baseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
              AvatarTimeLine(user: baseModel.createdBy),
              Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    baseModel.createdAt.toTimeAgo(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ))
            ],
          )),
      Padding(padding: EdgeInsets.fromLTRB(80, 4, 8, 4), child: child)
    ]);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BaseModel>('baseModel', baseModel));
  }
}

class CardFeedHub extends StatelessWidget {
  final HubMessage hubMessage;
  final GestureTapCallback onTap;

  const CardFeedHub({Key key, this.hubMessage, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardFeed(
        baseModel: hubMessage,
        child: Cards.timeLine(
          onTap: onTap,
          child: Column(
            children: [
              Text(
                hubMessage.title,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ));
  }
}

class CardFeedTalk extends StatelessWidget {
  final Talk talk;
  final GestureTapCallback onTap;

  const CardFeedTalk({Key key, this.talk, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardFeed(
        baseModel: talk,
        child: Cards.talks(
          padding: EdgeInsets.all(0),
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/youtube.webp",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                talk.title,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ));
  }
}

class CardFeedDirectMessage extends StatelessWidget {
  final DirectMessage directMessage;
  final GestureTapCallback onTap;

  const CardFeedDirectMessage({Key key, this.directMessage, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardFeed(
        baseModel: directMessage,
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
        ));
  }
}
