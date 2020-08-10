import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_text_builder.dart';
import 'package:in_a_bottle/local_message/message/direct_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/message/direct_message_event.dart';

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
        ReactiveTextBuilder(
            keyForm: KeysForm.title,
            bloc: _bloc,
            builder: (controller, error, onChanged) {
              return TextField(
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    errorText: error,
                  ),
                  onChanged: onChanged,
                  controller: controller);
            }),
        ReactiveTextBuilder(
            keyForm: KeysForm.text,
            bloc: _bloc,
            builder: (controller, error, onChanged) {
              return TextField(
                  decoration: InputDecoration(
                    hintText: 'Mensagem',
                    errorText: error,
                  ),
                  onChanged: onChanged,
                  controller: controller);
            }),
        FlatButton(
            onPressed: () =>
                _bloc.dispatchOn<DirectMessageEvent>(DirectMessageSave()),
            child: const Text("Salvar"))
      ])),
    ));
  }
}
