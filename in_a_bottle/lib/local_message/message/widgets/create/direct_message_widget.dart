import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/crud_widget.dart';
import 'package:in_a_bottle/local_message/message/widgets/create/direct_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';

class DirectMessageWidget extends StatefulWidget {
  @override
  _DirectMessageWidgetState createState() => _DirectMessageWidgetState();
}

class _DirectMessageWidgetState extends State<DirectMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return CrudWidget<DirectMessageForm, DirectMessageError, DirectMessageBloc>(
      builder: (_bloc, _factory) {
        return Container(
          child: SingleChildScrollView(
              child: Column(children: [
            _factory.build(DirectMessageForm.textTitle),
            _factory.build(DirectMessageForm.textContent),
            _factory.build(DirectMessageForm.boolPrivate),
            StreamBuilder<bool>(
                stream: _bloc.streamOf(key: DirectMessageForm.boolPrivate),
                builder: (date, snapshot) {
                  final _switcherState = snapshot.data ?? false;
                  if (!_switcherState) {
                    return Container();
                  }

                  return _factory.build(DirectMessageForm.textPassword,
                      parameters: <TextFieldParameter, dynamic>{
                        TextFieldParameter.obscureText: true
                      });
                }),
            _factory.build(DirectMessageForm.sliderReach),
            _factory.build(DirectMessageForm.actionSave)
          ])),
        );
      },
    );
  }
}
