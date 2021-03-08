import 'package:chameleon_resolver/chameleon_resolver.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

abstract class MessageHandler {
  void showError({required List<dynamic> errors, required String title, required BuildContext context});
  void showSucess({required String message, required String title, required BuildContext context});
  void showMessage({required String message, required String title, required BuildContext context});
}

class FlushMessageHandler implements MessageHandler {
  @override
  void showError({required List<dynamic> errors, required String title, required BuildContext context}) {
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
  void showMessage({required String message, required String title, required BuildContext context}) {
    // TODO: implement showMessage
  }

  @override
  void showSucess({required String message, required String title, required BuildContext context}) {
    // TODO: implement showSucess
  }
}
