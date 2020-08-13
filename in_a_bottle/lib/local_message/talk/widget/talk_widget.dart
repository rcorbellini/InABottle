import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/local_message/talk/talk_bloc.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';

class TalkWidget extends StatefulWidget {
  @override
  _TalkWidgetState createState() => _TalkWidgetState();
}

class _TalkWidgetState extends State<TalkWidget> {
  TalkBloc _bloc;
  WidgetFormFactory _factory;
  @override
  void initState() {
    _bloc = Injector().get();
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
      _factory.createdByEnum(TalkForm.actionSave),
    ]))));
  }
}
