import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/common/widget/crud_widget.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/message_treasure_bloc.dart';

class MessageTreasureWidget extends StatefulWidget {
  @override
  _MessageTreasureWidgetState createState() => _MessageTreasureWidgetState();
}

class _MessageTreasureWidgetState extends State<MessageTreasureWidget> {
  @override
  Widget build(BuildContext context) {
    return CrudWidget<DirectMessageForm, DirectMessageError, MessageTreasureBloc>(
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
            _factory.build(DirectMessageForm.tags),
            _factory.build(DirectMessageForm.actionSave)
          ])),
        );
      },
    );
  }
}
