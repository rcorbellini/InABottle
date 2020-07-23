import 'package:flutter/material.dart';
import 'package:geochat/local_message/talk/talk_dto.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  //TODO, fazer vir via arquitetura.
  List<Talk> talks = [
    Talk(title: 'Primeira talk'),
    Talk(title: 'Segunda talk'),
    Talk(title: 'Terceira talk'),
    Talk(title: 'Quarta talk'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      buildHeader(),

      //conteudo
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[buildTalks(), buildFeed()],
        ),
      ),

      buildFooter()
    ]));
  }

  Widget buildFeed() {
    return Container();
  }

  Widget buildTalks() {
    return Container(
        padding: const EdgeInsets.only(left: 10.0),
        height: MediaQuery.of(context).size.height * 0.30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Talks", style: Theme.of(context).textTheme.display1,),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              children: talks.map(_buildTalkItem).toList(),
            ))
          ],
        ));
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
          style:  Theme.of(context).textTheme.subhead,
        ));
  }

  //Footer
  //TODO fazer
  Widget buildFooter() {
    return Container();
  }

  //Footer
  //TODO fazer
  Widget buildHeader() {
    return Container();
  }
}
