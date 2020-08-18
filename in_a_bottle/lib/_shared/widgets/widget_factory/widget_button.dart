import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_component.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/form_factory.dart';

class WidgetButton<T> extends WidgetComponent<String> {
  final BaseBloc bloc;
  final T enumValue;

  const WidgetButton(
      {@required this.bloc,
      @required this.enumValue,
      Key key,
      Map<String, dynamic> parameters})
      : super(key: key, parameters: parameters);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => bloc.dispatchOn(enumValue),
        child: Text(
            AppLocalizations.of(context).translate(enumValue.toYamlKey())));
  }
}
