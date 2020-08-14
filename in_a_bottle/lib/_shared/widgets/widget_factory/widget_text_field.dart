import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/_shared/widgets/reactive_text_builder.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_component.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';

class WidgetTextField<T> extends WidgetComponent<TextFieldParameter> {
  final BaseBloc bloc;
  final T enumValue;

  const WidgetTextField({
    @required this.bloc,
    @required this.enumValue,
    Map<TextFieldParameter, dynamic> parameters,
    Key key,
  }) : super(key: key, parameters: parameters);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextBuilder(
      bloc: bloc,
      keyForm: enumValue,
      builder: (controller, onChanged, error) {
        return TextField(
            decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate(enumValue.toYamlKey()),
              errorText: error,
            ),
            obscureText: getParameter(TextFieldParameter.obscureText,
                defaultValue: false),
            onChanged: onChanged,
            controller: controller);
      },
    );
  }
}

enum TextFieldParameter { obscureText }
