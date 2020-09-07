import 'package:chameleon_resolver/chameleon_resolver.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

abstract class MessageHandler {
  void showError({List<Object> errors, String title, BuildContext context});
  void showSucess({String message, String title, BuildContext context});
  void showMessage({String message, String title, BuildContext context});
}

class FlushMessageHandler implements MessageHandler {
  @override
  void showError({List<Object> errors, String title, BuildContext context}) {
    if (errors.isEmpty) {
      return;
    }
    final msgErro = errors
        .map((e) => ChamaleonLocalizations.of(context).translate(e
            .toString()
            .split(".")
            .map((e) => e[0].toLowerCase() + e.substring(1))
            .join(".")))
        .toList()
        .join("\n\u{1F784} ");

    FlushbarHelper.createError(
            message: "\u{1F784} $msgErro",
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
