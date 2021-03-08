import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/loading_indicator.dart';
import 'package:in_a_bottle/features/treasure/presentation/home/bloc/home_bloc.dart';
import 'package:in_a_bottle/features/treasure/presentation/home/bloc/home_event.dart';
import 'package:in_a_bottle/home/widgets/home_widget_helpers.dart';
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

    return const LoadingIndicator();
  }

  Widget _buildTalkItem(Talk talk) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Cards.talks(
          padding: EdgeInsets.all(0),
          onTap: () => homeBloc.dispatchOn<HomeEvent>(GoToRoute(
              InteractTalkBloc.route,
              params: {"selector": talk.selector})),
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
          width: MediaQuery.of(context).size.width * 0.85,
        ));
  }
}
