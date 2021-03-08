import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/common/widget/crud_widget.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkWidget extends StatefulWidget {
  @override
  _TalkWidgetState createState() => _TalkWidgetState();
}

class _TalkWidgetState extends State<TalkWidget> {
  @override
  Widget build(BuildContext context) {
    return CrudWidget<TalkForm, TalkError, TalkBloc>(
      builder: (_bloc, _factory) {
        return Container(
            child: SingleChildScrollView(
                child: Column(children: [
          _factory.build(TalkForm.textTitle),
          _factory.build(TalkForm.textDescription),
          _factory.build(TalkForm.dateRangeDuration),
          _factory.build(TalkForm.boolPrivate),
          StreamBuilder<bool>(
              stream: _bloc.streamOf(key: TalkForm.boolPrivate),
              builder: (date, snapshot) {
                final _switcherState = snapshot.data ?? false;

                return Visibility(
                    visible: _switcherState,
                    child: _factory.build(TalkForm.textPassword,
                        parameters: <TextFieldParameter, dynamic>{
                          TextFieldParameter.obscureText: true
                        }));
              }),
          _factory.build(TalkForm.sliderReach),
          _factory.build(TalkForm.actionSave),
        ])));
      },
    );
  }
}
