import 'package:flutter/material.dart';
import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/home/home_event.dart';
import 'package:geochat/home/home_talk_list_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = Injector().get<HomeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      buildHeader(),

      //conteudo
      Expanded(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeTalkListWidget(
              homeBloc: homeBloc,
              context: context,
            ),
            buildFeed()
          ],
        ),
      )),

      buildFooter()
    ]));
  }

  Widget buildFeed() {
    return Container();
  }

  Widget buildFooter() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: const Text("Adicionar Talk"),
            onPressed: () {
              homeBloc.dispatchOn<HomeEvent>(GoToRoute("/addTalk"));
            },
          ),
          FlatButton(
            child: const Text("Adicionar Chat"),
            onPressed: () {
              homeBloc.dispatchOn<HomeEvent>(GoToRoute("/addChat"));
            },
          ),
          FlatButton(
            child: const Text("Adicionar Item"),
            onPressed: () {
              homeBloc.dispatchOn<HomeEvent>(GoToRoute("/addItem"));
            },
          ),
        ],
      ),
    );
  }

  //Footer
  //TODO fazer
  Widget buildHeader() {
    return Container();
  }
}
