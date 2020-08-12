import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/utils.dart';
import 'package:in_a_bottle/widget_utils/widget_button.dart';
import 'package:in_a_bottle/widget_utils/widget_date_range.dart';
import 'package:in_a_bottle/widget_utils/widget_text_field.dart';

class WidgetFormFactory<T> {
  final BaseBloc bloc;
  final BuildContext context;

  WidgetFormFactory({
    @required this.bloc,
    @required this.context,
  })  : assert(bloc != null),
        assert(context != null);

  Widget createdByEnum(T enumValue, {Map parameters}) {
    print(enumToString(enumValue));
    print(enumValue.toString());
    print(enumValue.toYamlKey());
    if (!isEnum(enumValue)) {
      throw Exception('Only enums allowed');
    }

    final stringValue = enumToString(enumValue);

    if (stringValue.startsWith(enumToString(EnumPrefix.text))) {
      return WidgetTextField<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<TextFieldParameter, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.action))) {
      return WidgetButton<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.dateRange))) {
      return WidgetDateRange<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<DateRangeParameter, dynamic>,
      );
    }

    return const Text("not found");
  }
}

extension EnumKey on Object {
  String toYamlKey() {
    return toString()
        .replaceFirst(enumToString(EnumPrefix.text), '')
        .replaceFirst(enumToString(EnumPrefix.action), '')
        .replaceFirst(enumToString(EnumPrefix.dateRange), '');
  }
}

enum EnumPrefix { action, text, dateRange }
