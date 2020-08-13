import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/chat/chat_dto.dart';

abstract class ChatRepository
    implements BaseRepository<Chat, String> {}

class ChatDataRepository extends ChatRepository {
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<Chat>> loadAll() {
    // TODO: implement loadAll
    return null;
  }

  @override
  Future<Chat> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future save(Chat entity) {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll(Iterable<Chat> entities) {
    // TODO: implement saveAll
    return null;
  }
}
