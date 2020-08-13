import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';
import 'package:in_a_bottle/local_message/chat/chat_bloc.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';
import 'package:fancy_stream/fancy_stream.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ChatBloc _bloc;
  WidgetFormFactory _factory;

  @override
  void initState() {
    _bloc = Injector().get();
    _factory = WidgetFormFactory<ChatForm>(bloc: _bloc, context: context);
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
        _factory.createdByEnum(ChatForm.textTitle),
        _factory.createdByEnum(ChatForm.boolPrivate),
        StreamBuilder<bool>(
            stream: _bloc.streamOf(key: ChatForm.boolPrivate),
            builder: (date, snapshot) {
              final _switcherState = snapshot.data ?? false;
              if (!_switcherState) {
                return Container();
              }

              return _factory.createdByEnum(ChatForm.textPassword,
                  parameters: <TextFieldParameter, dynamic>{
                    TextFieldParameter.obscureText: true
                  });
            }),
        _factory.createdByEnum(ChatForm.sliderReach),
        _factory.createdByEnum(ChatForm.actionSave)
      ])),
    ));
  }
}
