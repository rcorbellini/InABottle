import 'package:in_a_bottle/features/session/domain/models/auth_user.dart';

abstract class LoginEvent {}

class LoggingByGoogle extends LoginEvent {
  LoggingByGoogle(this.authUser);

  final AuthUser? authUser;
}
