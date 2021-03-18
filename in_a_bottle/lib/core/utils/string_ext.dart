import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters/localization/localization_helper.dart';

extension LocalizedString on String {
  String tr({required BuildContext context }) =>
      LocalizationsYamlHelper.of(context).translate(this);
}
