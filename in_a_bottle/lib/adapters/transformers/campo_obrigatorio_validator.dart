import 'dart:async';

mixin CampoObrigatorioValidator {
  final StreamTransformer<String, String> validateObrigatorio =
      StreamTransformer<String, String>.fromHandlers(handleData: (campo, sink) {
    if (campo == null || campo.trim().isEmpty) {
      sink.addError('Informe um valor válido');
    } else {
      sink.add(campo);
    }
  });
}
