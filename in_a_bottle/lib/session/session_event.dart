import 'package:in_a_bottle/user/user.dart';

abstract class SessionEvent {}

class Unauthenticated extends SessionEvent {}

class LoggedIn extends SessionEvent {
  final User user;

  LoggedIn(this.user);
}

class LoggedOut extends SessionEvent {}
