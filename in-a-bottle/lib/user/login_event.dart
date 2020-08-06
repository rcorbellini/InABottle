import 'package:in_a_bottle/user/user_dto.dart';

abstract class LoginEvent {}

class Logging extends LoginEvent {
  final User user;

  Logging(this.user);
}
