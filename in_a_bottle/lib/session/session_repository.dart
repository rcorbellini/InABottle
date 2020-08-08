import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/session/session_dto.dart';
abstract class SessionRepository {
  Future clean();

  Future save(Session session);

  Future<Session> load();
}

class SessionDataRepository extends BaseRepository<Session, String>
    implements SessionRepository {
  //todo mover pro datastore
  Session session;
  @override
  Future<Session> load() async {
    return session;
  }

  @override
  Future<List<Session>> loadAll() {
    throw UnimplementedError("Not implemented");
  }

  @override
  Future<Session> loadByKey(String key) {
    throw UnimplementedError("Not implemented");
  }

  @override
  Future save(Session entity) {
    session = entity;
  }

  @override
  Future saveAll(Iterable<Session> entities) {
    throw UnimplementedError("Not implemented");
  }

  @override
  Future clean() {
    session = null;
  }

  @override
  Future delete(String key) {
    throw UnimplementedError("Not implemented");
  }
}
