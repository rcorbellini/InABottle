import 'package:flutter/material.dart';
import 'package:fancy_stream/fancy_stream.dart';

class WidgetSwitch<T> extends StatelessWidget {
  final T enumValue;
  final Disposable bloc;
  final Map<String, dynamic> parameters;

  const WidgetSwitch({Key key, this.enumValue, this.bloc, this.parameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.streamOf(key: enumValue),
      builder: (date, snapshot) {
        final _switcherState = snapshot.data ?? false;
        return Switch(
            value: _switcherState,
            onChanged: (b) => bloc.dispatchOn(b, key: enumValue));
      },
    );
  }
}
