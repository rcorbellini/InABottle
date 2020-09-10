import 'package:flutter/material.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/home_event.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:meta/meta.dart';

class HomeTalkListWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final BuildContext context;

  const HomeTalkListWidget({@required this.homeBloc, @required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
        padding: const EdgeInsets.only(left: 10.0),
        height: MediaQuery.of(context).size.height * 0.30,
        child: StreamBuilder<List<Talk>>(
            stream: homeBloc.streamOf<List<Talk>>(), builder: _builTalksList));
  }

  Widget _builTalksList(
      BuildContext context, AsyncSnapshot<List<Talk>> snapshot) {
    if (snapshot.hasData) {
      final talks = snapshot.data;
      return ListView(
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: talks.map(_buildTalkItem).toList(),
      );
    }

    return const CircularProgressIndicator();
  }

  Widget _buildTalkItem(Talk talk) {
    return GestureDetector(
      onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
          InteractTalkBloc.route,
          params: {"selector": talk.selector})),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          padding: const EdgeInsets.all(16),
          child: Text(
            talk.title,
            style: Theme.of(context).textTheme.subhead,
          )),
    );
  }
}
