import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_text_builder.dart';
import 'package:in_a_bottle/local_message/message/direct_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/widget_utils/widget_form_factory.dart';
import 'package:in_a_bottle/widget_utils/widget_text_field.dart';

class DirectMessageWidget extends StatefulWidget {
  @override
  _DirectMessageWidgetState createState() => _DirectMessageWidgetState();
}

class _DirectMessageWidgetState extends State<DirectMessageWidget> {
  DirectMessageBloc _bloc;
  WidgetFormFactory _factory;
  @override
  void initState() {
    _bloc = Injector().get();
    _factory =
        WidgetFormFactory<DirectMessageForm>(bloc: _bloc, context: context);
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
        _factory.createdByEnum(DirectMessageForm.textTitle),
        _factory.createdByEnum(DirectMessageForm.textContent),
        StreamBuilder<bool>(
          stream: _bloc.streamOf(key: DirectMessageForm.private),
          builder: (date, snapshot) {
            final _switcherState = snapshot.data ?? false;
            return Switch(
                value: _switcherState,
                onChanged: (b) =>
                    _bloc.dispatchOn(b, key: DirectMessageForm.private));
          },
        ),
        StreamBuilder<bool>(
            stream: _bloc.streamOf(key: DirectMessageForm.private),
            builder: (date, snapshot) {
              final _switcherState = snapshot.data ?? false;
              if (!_switcherState) {
                return Container();
              }

              return _factory.createdByEnum(DirectMessageForm.textPassword,
                  parameters: <TextFieldParameter, dynamic>{
                    TextFieldParameter.obscureText: true
                  });
            }),
        StreamBuilder<double>(
            stream: _bloc.streamOf(key: DirectMessageForm.reach),
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
                onChanged: (v) =>
                    _bloc.dispatchOn(v, key: DirectMessageForm.reach),
              );
            }),
        _factory.createdByEnum(DirectMessageForm.actionSave)
      ])),
    ));
  }
}
