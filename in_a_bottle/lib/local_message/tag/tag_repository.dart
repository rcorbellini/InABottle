import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/tag/tag.dart';

abstract class TagRepository extends BaseRepository<Tag, String> {}

class TagDataRepository extends TagRepository {
  final memory = [
    Tag(description: "#TI"),
    Tag(description: "#ciencia"),
    Tag(description: "#teste"),
  ];
  @override
  Future delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> loadAll() async {
    return memory;
  }

  @override
  Future<Tag> loadByKey(String key) {
    // TODO: implement loadByKey
    throw UnimplementedError();
  }

  @override
  Future save(Tag entity) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future saveAll(Iterable<Tag> entities) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }
}
