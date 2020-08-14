import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/talk/talk_dto.dart';

abstract class TalkRepository extends BaseRepository<Talk, String> {}

class TalkDataRepository implements TalkRepository {
  static final memory = [
    Talk(title: "teste"),
    Talk(title: "teste1"),
    Talk(title: "teste2"),
    Talk(title: "teste3"),
    Talk(title: "teste4")
  ];
  @override
  Future<List<Talk>> loadAll() async {
    return memory;
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Talk> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future save(Talk entity) async {
    memory.add(entity);
  }

  @override
  Future saveAll(Iterable<Talk> entities) {
    // TODO: implement saveAll
    return null;
  }
}
