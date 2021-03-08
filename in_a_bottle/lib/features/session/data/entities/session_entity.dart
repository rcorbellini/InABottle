import 'package:in_a_bottle/features/session/domain/models/session.dart';

class SessionEntity<T> extends Session<T> {
  SessionEntity({required payload, required token})
      : super(token: token, payload: payload);
}
