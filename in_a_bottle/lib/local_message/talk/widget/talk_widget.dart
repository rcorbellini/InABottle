import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_text_builder.dart';
import 'package:in_a_bottle/local_message/talk/talk_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class TalkWidget extends StatefulWidget {
  @override
  _TalkWidgetState createState() => _TalkWidgetState();
}

class _TalkWidgetState extends State<TalkWidget> {
  TalkBloc _bloc;
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
        bloc: _bloc,
        keyForm: TalkKeysForm.title,
        builder: (controller, onChanged, error) {
          return TextField(
              decoration: InputDecoration(
                hintText: 'Titulo',
                errorText: error,
              ),
              onChanged: onChanged,
              controller: controller);
        },
      ),
      ReactiveTextBuilder(
        bloc: _bloc,
        keyForm: TalkKeysForm.description,
        builder: (controller, onChanged, error) {
          return TextField(
              decoration: InputDecoration(
                hintText: 'Descricao',
                errorText: error,
              ),
              onChanged: onChanged,
              controller: controller);
        },
      ),
      InkWell(
          onTap: () async {
            final dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)));
            _bloc.dispatchOn(dateRange, key: TalkKeysForm.dateRange);
          },
          child: StreamBuilder<DateTimeRange>(
              stream: _bloc.streamOf(key: TalkKeysForm.dateRange),
              builder: (context, snpashot) {
                final dateRange = snpashot.data; 
                return Text(dateRange?.toString()?? 'selecione uma data');
              })),
      FlatButton(
          onPressed: () => _bloc.dispatchOn(TalkKeysForm.actionSave),
          child: const Text("Salvar"))
    ]))));
  }
}
