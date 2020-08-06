import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/session/session_dto.dart';

class SessionRepository extends BaseRepository<Session, String>{
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<Session>> loadAll() {
    // TODO: implement loadAll
    return null;
  }

  @override
  Future<Session> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future save() {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll() {
    // TODO: implement saveAll
    return null;
  }
  
}