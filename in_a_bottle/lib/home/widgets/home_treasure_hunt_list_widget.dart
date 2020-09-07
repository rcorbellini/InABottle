import 'package:flutter/material.dart';
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
        height: MediaQuery.of(context).size.height * 0.10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "TreasureHunts",
              style: Theme.of(context).textTheme.display1,
            ),
            Expanded(
                child: StreamBuilder<List<TreasureHunt>>(
                    stream: homeBloc.streamOf<List<TreasureHunt>>(),
                    builder: _builTreasureHuntsList))
          ],
        ));
  }

  Widget _builTreasureHuntsList(
      BuildContext context, AsyncSnapshot<List<TreasureHunt>> snapshot) {
    if (snapshot.hasData) {
      final treasureHunts = snapshot.data;
      return ListView(
        scrollDirection: Axis.horizontal,
        children: treasureHunts.map(_buildTreasureHuntItem).toList(),
      );
    }

    return const CircularProgressIndicator();
  }

  Widget _buildTreasureHuntItem(TreasureHunt treasureHunt) {
    return GestureDetector(
      onTap: () =>
          null, //homeBloc.dispatchOn<HomeEvent>(       GoToRoute(InteractTreasureHuntBloc.route, params: {"selector": treasureHunt.selector})),
      child: Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.height * 0.30,
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
