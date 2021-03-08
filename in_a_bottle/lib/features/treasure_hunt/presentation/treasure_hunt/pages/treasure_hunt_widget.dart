import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/common/widget/crud_widget.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/treasure_hunt/bloc/treasure_hunt_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TreasureHuntWidget extends StatefulWidget {
  @override
  _TreasureHuntWidgetState createState() => _TreasureHuntWidgetState();
}

class _TreasureHuntWidgetState extends State<TreasureHuntWidget> {
  @override
  Widget build(BuildContext context) {
    return CrudWidget<TreasureHuntForm, TreasureHuntError, TreasureHuntBloc>(
      builder: (_bloc, _factory) {
        return Container(
            child: SingleChildScrollView(
                child: Column(children: [
          _factory.build(TreasureHuntForm.textTitle),
          _factory.build(TreasureHuntForm.textDescription),
          _factory.build(TreasureHuntForm.dateRangeDuration),
          _factory.build(TreasureHuntForm.boolPrivate),
          StreamBuilder<bool>(
              stream: _bloc.streamOf(key: TreasureHuntForm.boolPrivate),
              builder: (context, snapshot) {
                final _switcherState = snapshot.data ?? false;

                return Visibility(
                    visible: _switcherState,
                    child: _factory.build(TreasureHuntForm.textPassword,
                        parameters: <TextFieldParameter, dynamic>{
                          TextFieldParameter.obscureText: true
                        }));
              }),
          _factory.build(TreasureHuntForm.sliderReach),
          _factory.build(TreasureHuntForm.actionAddMessage),
          StreamBuilder<List<DirectMessage>>(
            stream: _bloc.streamOf(key: TreasureHuntForm.messages),
            builder: (context, snapshot) {
              final messages = snapshot.data ?? [];
              return Text(messages.toString());
            },
          ),
          _factory.build(TreasureHuntForm.actionSave),
        ])));
      },
    );
  }
}
