import 'package:geochat/_shared/archtecture/base_repository.dart';
import 'package:geochat/user/user_dto.dart';

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
  Future save() {
    return null;
  }

  @override
  Future saveAll() {
    return null;
  }
}
