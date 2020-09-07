import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/user/user_dto.dart';

abstract class BaseModel {
  String get selector;
  User get createdBy;
  Local get createdOn;
  DateTime get createdAt;
  String get status;
}
