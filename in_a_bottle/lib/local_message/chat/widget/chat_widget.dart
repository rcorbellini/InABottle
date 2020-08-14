import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/crud_widget.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';
import 'package:in_a_bottle/local_message/chat/chat_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return CrudWidget<ChatForm, ChatError, ChatBloc>(
        builder: (_bloc, _factory) {
      return Container(
        child: SingleChildScrollView(
            child: Column(children: [
          _factory.build(ChatForm.textTitle),
          _factory.build(ChatForm.boolPrivate),
          StreamBuilder<bool>(
              stream: _bloc.streamOf(key: ChatForm.boolPrivate),
              builder: (date, snapshot) {
                final _switcherState = snapshot.data ?? false;
                if (!_switcherState) {
                  return Container();
                }

                return _factory.build(ChatForm.textPassword,
                    parameters: <TextFieldParameter, dynamic>{
                      TextFieldParameter.obscureText: true
                    });
              }),
          _factory.build(ChatForm.sliderReach),
          _factory.build(ChatForm.actionSave)
        ])),
      );
    });
  }
}
