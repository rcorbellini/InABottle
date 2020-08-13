import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';

abstract class MessageHandler {
  void showError({List<Object> errors, Object enumTitle, BuildContext context});
  void showSucess({String message, String title, BuildContext context});
  void showMessage({String message, String title, BuildContext context});
}

class FlushMessageHandler implements MessageHandler {
  @override
  void showError(
      {List<Object> errors, Object enumTitle, BuildContext context}) {
    final msgErro = errors
        .map((e) => AppLocalizations.of(context).translate(e.toString()))
        .toList()
        .join("\n-");

    final title = AppLocalizations.of(context).translate(enumTitle.toString());

    FlushbarHelper.createError(
            message: "-$msgErro",
            title: title,
            duration: const Duration(seconds: 5))
        .show(context);
  }

  @override
  void showMessage({String message, String title, BuildContext context}) {
    // TODO: implement showMessage
  }

  @override
  void showSucess({String message, String title, BuildContext context}) {
    // TODO: implement showSucess
  }
}
