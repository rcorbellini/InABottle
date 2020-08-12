import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/widget_utils/widget_form_factory.dart';

class WidgetButton<T> extends StatelessWidget {
  final BaseBloc bloc;
  final T enumValue;
  final Map<String, dynamic> parameters;

  const WidgetButton(
      {@required this.bloc,
      @required this.enumValue,
      Key key,
      this.parameters = const <String, dynamic>{}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => bloc.dispatchOn(enumValue),
        child: Text(
            AppLocalizations.of(context).translate(enumValue.toYamlKey())));
  }
}
