import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_text_builder.dart';
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
        ReactiveTextBuilder(
            keyForm: KeysForm.title,
            bloc: _bloc,
            builder: (controller, onChanged, error) {
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
            builder: (controller, onChanged, error) {
              return TextField(
                  decoration: InputDecoration(
                    hintText: 'Mensagem',
                    errorText: error,
                  ),
                  onChanged: onChanged,
                  controller: controller);
            }),
        StreamBuilder<bool>(
          stream: _bloc.streamOf(key: KeysForm.private),
          builder: (date, snapshot) {
            final _switcherState = snapshot.data ?? false;
            return Switch(
                value: _switcherState,
                onChanged: (b) => _bloc.dispatchOn(b, key: KeysForm.private));
          },
        ),
        StreamBuilder<bool>(
            stream: _bloc.streamOf(key: KeysForm.private),
            builder: (date, snapshot) {
              final _switcherState = snapshot.data ?? false;
              if (!_switcherState) {
                return Container();
              }

              return ReactiveTextBuilder(
                  keyForm: KeysForm.password,
                  bloc: _bloc,
                  builder: (controller, onChanged, error) {
                    return TextField(
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          errorText: error,
                        ),
                        obscureText: true,
                        onChanged: onChanged,
                        controller: controller);
                  });
            }),
        StreamBuilder<double>(
            stream: _bloc.streamOf(key: KeysForm.reach),
            builder: (date, snapshot) {
              final value = snapshot?.data ?? 1;
              final label =
                  value == 1 ? 'susurro' : value == 2 ? 'padrão' : 'grito';
              return Slider(
                value: value,
                min: 1.0,
                max: 3.0,
                label: label,
                divisions: 2,
                onChanged: (v) => _bloc.dispatchOn(v, key: KeysForm.reach),
              );
            }),
        FlatButton(
            onPressed: () => _bloc.dispatchOn(KeysForm.actionSave),
            child: const Text("Salvar"))
      ])),
    ));
  }
}
