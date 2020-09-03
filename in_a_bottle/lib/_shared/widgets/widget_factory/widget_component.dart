import 'package:flutter/material.dart';

abstract class WidgetComponent<T> extends StatelessWidget {
  final Map<T, dynamic> parameters;

  const WidgetComponent({Key key, this.parameters}) : super(key: key);

  V getParameter<V>(T param, {V defaultValue}) {
    if (parameters == null) {
      return defaultValue;
    }

    return parameters[param] as V ?? defaultValue;
  }
  
}
