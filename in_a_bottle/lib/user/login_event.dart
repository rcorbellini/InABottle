import 'package:in_a_bottle/user/user.dart';

abstract class LoginEvent {}

class Logging extends LoginEvent {
  final User user;

  Logging(this.user);
}
