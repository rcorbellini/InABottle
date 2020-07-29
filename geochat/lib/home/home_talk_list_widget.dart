import 'package:flutter/material.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/local_message/talk/talk_dto.dart';
import 'package:fancy_stream/fancy_stream.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Talks",
              style: Theme.of(context).textTheme.display1,
            ),
            Expanded(
                child: StreamBuilder<List<Talk>>(
                    stream: homeBloc.streamOf<List<Talk>>(),
                    builder: _builListTalks))
          ],
        ));
  }

  Widget _builListTalks(
      BuildContext context, AsyncSnapshot<List<Talk>> snapshot) {
    if (snapshot.hasData) {
      final talks = snapshot.data;
      return ListView(
        scrollDirection: Axis.horizontal,
        children: talks.map(_buildTalkItem).toList(),
      );
    }

    return const CircularProgressIndicator();
  }

  Widget _buildTalkItem(Talk talk) {
    return Container(
        margin: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
        padding: const EdgeInsets.all(16),
        child: Text(
          talk.title,
          style: Theme.of(context).textTheme.subhead,
        ));
  }
}
