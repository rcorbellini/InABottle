import 'dart:async';

mixin NameValidator {
  final StreamTransformer<String, String> validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (!name.trim().contains(" ")) {
      sink.addError("Informe o nome completo");
    } else {
      sink.add(name.trim());
    }
  });
}
