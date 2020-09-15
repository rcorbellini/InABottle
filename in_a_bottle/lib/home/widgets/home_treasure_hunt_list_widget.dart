import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/loading_indicator.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/home/widgets/home_feed_list_widget.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt.dart';
import 'package:meta/meta.dart';

class HomeTreasureHuntListWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final BuildContext context;

  const HomeTreasureHuntListWidget(
      {@required this.homeBloc, @required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
        padding: const EdgeInsets.only(left: 10.0),
        height: 170,
        child: StreamBuilder<List<TreasureHunt>>(
            stream: homeBloc.streamOf<List<TreasureHunt>>(),
            builder: _builTreasureHuntsList));
  }

  Widget _builTreasureHuntsList(
      BuildContext context, AsyncSnapshot<List<TreasureHunt>> snapshot) {
    if (snapshot.hasData) {
      final treasureHunts = snapshot.data;
      return ListView(
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: treasureHunts.map(_buildTreasureHuntItem).toList(),
      );
    }

    return const LoadingIndicator();
  }

//corta tudo
//cliprect
  Widget _buildTreasureHuntItem(TreasureHunt treasureHunt) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Cards.treasureHunt(
              width: MediaQuery.of(context).size.width * 0.85,
              onTap: () => homeBloc.dispatchOn<HomeEvent>(
                  GoToRoute("", params: {"selector": treasureHunt.selector})),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Image.asset(
                        "assets/images/staticmap.png",
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                              padding: EdgeInsets.all(16),
                              width: 180,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    treasureHunt.title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    treasureHunt.description,
                                    style: Theme.of(context).textTheme.overline,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Pontos :",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                      Coin.small(
                                        treasureHunt?.points,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Pontos extra:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                      Coin.small(
                                        treasureHunt?.points,
                                      )
                                    ],
                                  ),
                                  AvatarsReactions(
                                      reactions:
                                          treasureHunt.reactions?.toList())
                                ],
                              ))),
                      Positioned(
                        top: -12,
                        left: -12,
                        child: AvatarTimeLine(user: treasureHunt.createdBy,),
                      ),
                    ],
                  )),
            ), FlagsOverflow(
                  contentFlag: Text(
                    treasureHunt?.messages?.length?.toString() ?? "0",
                    style: Theme.of(context).textTheme.overline.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  iconflag: Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  background: Colors.black,
                )
          ],
        ));
  }
}
