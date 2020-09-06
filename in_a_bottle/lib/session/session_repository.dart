import 'package:in_a_bottle/session/session_dto.dart';

abstract class SessionRepository {
  Future clean();

  Future save(Session session);

  Future<Session> load();
}

class SessionDataRepository implements SessionRepository {
  //todo mover pro datastore
  Session session;
  @override
  Future<Session> load() async {
    return session;
  }

  @override
  Future save(Session entity) async {
    session = entity;
  }

  @override
  Future clean() async {
    session = null;
  }
}
