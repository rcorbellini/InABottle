import 'package:in_a_bottle/features/session/domain/models/session.dart';

abstract class SessionRepository {
  Future<void> clean();

  Future save(Session session);

  Future<Session<T>?> load<T>();
}