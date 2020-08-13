import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_component.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';

class WidgetSlider<T> extends WidgetComponent<SliderParameter> {
  final BaseBloc bloc;
  final T enumValue;

  const WidgetSlider(
      {Key key,
      this.bloc,
      this.enumValue,
      Map<SliderParameter, dynamic> parameters})
      : super(key: key, parameters: parameters);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: bloc.streamOf(key: enumValue),
        builder: (date, snapshot) {
          final value = snapshot?.data ?? 1;
          final label = AppLocalizations.of(context)
              .translate("${enumValue.toYamlKey()}.v$value");
          return Slider(
            value: value,
            min: getParameter(SliderParameter.min, defaultValue: 1.0),
            max: getParameter(SliderParameter.min, defaultValue: 3.0),
            label: label,
            divisions: getParameter(SliderParameter.division, defaultValue: 2),
            onChanged: (v) => bloc.dispatchOn(v, key: enumValue),
          );
        });
  }
}

enum SliderParameter { min, max, division }
