import 'package:in_a_bottle/features/user/user.dart';

abstract class BaseModel {
  String get selector;
  User get createdBy;
  DateTime get createdAt;
  String get status;

  copyWith({
    String selector,
  });
}

const String statusPendente = 'pendente';
const String statusProcessado = 'processado';
