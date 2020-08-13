import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_component.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_form_factory.dart';

class WidgetDateRange<T> extends WidgetComponent<DateRangeParameter> {
  final T enumValue;
  final BaseBloc bloc;

  const WidgetDateRange(
      {@required this.enumValue,
      @required this.bloc,
      Key key,
      Map<DateRangeParameter, dynamic> parameters})
      : super(key: key, parameters: parameters);

  @override
  Widget build(
    BuildContext context,
  ) {
    final firstDate = getParameter(DateRangeParameter.firstDate,
        defaultValue: DateTime.now());
    final lastDate = getParameter(DateRangeParameter.lastDate,
        defaultValue: DateTime.now().add(const Duration(days: 30)));

    return InkWell(
        onTap: () async {
          final dateRange = await showDateRangePicker(
              context: context, firstDate: firstDate, lastDate: lastDate);
          bloc.dispatchOn(dateRange, key: enumValue);
        },
        child: StreamBuilder<DateTimeRange>(
            stream: bloc.streamOf(key: enumValue),
            builder: (context, snpashot) {
              final dateRange = snpashot.data;
              return Text(dateRange?.toString() ??
                  AppLocalizations.of(context)
                      .translate(enumValue.toYamlKey()));
            }));
  }
}

enum DateRangeParameter { firstDate, lastDate }
