import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_snapshot.dart';
import 'package:in_a_bottle/local_message/message/direct_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class DirectMessageWidget extends StatefulWidget {
  @override
  _DirectMessageWidgetState createState() => _DirectMessageWidgetState();
}

class _DirectMessageWidgetState extends State<DirectMessageWidget> {
  DirectMessageBloc _bloc;
  @override
  void initState() {
    _bloc = Injector().get();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
          child: Column(children: [
        ReactiveSnapshot(
            stream: _bloc.streamOf(key: "titulo"),
            builder: (controller, error) {
              return TextField(
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    errorText: error,
                  ),
                  onChanged: (text) => _bloc.dispatchOn(text, key: "title"),
                  controller: controller);
            }),
        ReactiveSnapshot(
            stream: _bloc.streamOf(key: "text"),
            builder: (controller, error) {
              return TextField(
                  decoration: InputDecoration(
                    hintText: 'Text',
                    errorText: error,
                  ),
                  onChanged: (text) => _bloc.dispatchOn(text, key: "text"),
                  controller: controller);
            })
      ])),
    ));
  }
}
