import 'package:flutter/material.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
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

    return const CircularProgressIndicator();
  }

  Widget _buildTreasureHuntItem(TreasureHunt treasureHunt) {
    return GestureDetector(
      onTap: () => homeBloc.dispatchOn<HomeEvent>(
          GoToRoute("", params: {"selector": treasureHunt.selector})),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          padding: const EdgeInsets.all(16),
          child: Text(
            treasureHunt.title,
            style: Theme.of(context).textTheme.subhead,
          )),
    );
  }
}
