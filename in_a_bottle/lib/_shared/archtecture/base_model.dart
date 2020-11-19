import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/user/user.dart';

abstract class BaseModel {
  String get selector;
  User get createdBy;
  Local get createdOn;
  DateTime get createdAt;
  String get status;

  copyWith({
    String selector,
  });
}

const String statusPendente = 'pendente';
const String statusProcessado = 'processado';
