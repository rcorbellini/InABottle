import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class UserRepository extends BaseRepository<User, String> {
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<User>> loadAll() {
    return null;
  }

  @override
  Future<User> loadByKey(String key) {
    return null;
  }

  @override
  Future save(User entity) {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll(Iterable<User> entities) {
    // TODO: implement saveAll
    return null;
  }
}
