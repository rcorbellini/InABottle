import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';

abstract class ChatRepository
    implements BaseRepository<ChatRepository, String> {}

class ChatDataRepository extends ChatRepository {
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<ChatRepository>> loadAll() {
    // TODO: implement loadAll
    return null;
  }

  @override
  Future<ChatRepository> loadByKey(String key) {
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
