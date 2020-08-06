import 'package:geochat/_shared/archtecture/base_repository.dart';
import 'package:geochat/local_message/talk/talk_dto.dart';

abstract class TalkRepository extends BaseRepository<Talk, String> {}

class TalkDataRepository implements TalkRepository {
  @override
  Future<List<Talk>> loadAll() async {
    return [
      Talk(title: "teste"),
      Talk(title: "teste1"),
      Talk(title: "teste2"),
      Talk(title: "teste3"),
      Talk(title: "teste4")
    ];
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
