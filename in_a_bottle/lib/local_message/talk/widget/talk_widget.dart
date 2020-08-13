import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/message_handler.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';
import 'package:in_a_bottle/local_message/talk/talk_bloc.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkWidget extends StatefulWidget {
  @override
  _TalkWidgetState createState() => _TalkWidgetState();
}

class _TalkWidgetState extends State<TalkWidget> {
  TalkBloc _bloc;
  WidgetFormFactory _factory;
  MessageHandler _messageHandler;
  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.listenOn<List<TalkError>>(_onError,
        key: TalkForm.errorMessages);
    _messageHandler = Injector().get();
    _factory = WidgetFormFactory<TalkForm>(bloc: _bloc, context: context);
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
      _factory.createdByEnum(TalkForm.textTitle),
      _factory.createdByEnum(TalkForm.textDescription),
      _factory.createdByEnum(TalkForm.dateRangeDuration),
      _factory.createdByEnum(TalkForm.boolPrivate),
        StreamBuilder<bool>(
            stream: _bloc.streamOf(key: TalkForm.boolPrivate),
            builder: (date, snapshot) {
              final _switcherState = snapshot.data ?? false;
              if (!_switcherState) {
                return Container();
              }

              return _factory.createdByEnum(TalkForm.textPassword,
                  parameters: <TextFieldParameter, dynamic>{
                    TextFieldParameter.obscureText: true
                  });
            }),
        _factory.createdByEnum(TalkForm.sliderReach),
      _factory.createdByEnum(TalkForm.actionSave),
    ]))));
  }


  void _onError(List<TalkError> errors) {
    _messageHandler.showError(
        errors: errors, enumTitle: TalkError.title, context: context);
  }
}
