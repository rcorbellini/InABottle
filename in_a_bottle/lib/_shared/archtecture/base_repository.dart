import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';

abstract class BaseRepository<ENTITY extends BaseModel, KEY,
    STORAGE extends BaseDataStorage<ENTITY, KEY>> {
  STORAGE get dao;
  STORAGE get http;

  Stream<List<ENTITY>> asyncLoadAll() async* {
    yield await dao?.loadAll();
    yield await http?.loadAll();
  }

  Future<List<ENTITY>> loadAll() async {
    await http?.loadAll();
    return dao?.loadAll();
  }

  Stream<ENTITY> asyncLoadByKey(KEY key) async* {
    yield await dao?.loadByKey(key);
    yield await http?.loadByKey(key);
  }

  Future<ENTITY> loadByKey(KEY key) async {
    await http?.loadByKey(key);
    return await dao?.loadByKey(key);
  }

  Future save(ENTITY entity) async {
    if (entity.selector == null) {
      await dao?.insert(entity);
      await http?.insert(entity);
    } else {
      await dao?.update(entity.selector, entity);
      await http?.update(entity.selector, entity);
    }
  }

  Future delete(KEY key) async {
    await dao?.delete(key);
    await http?.delete(key);
  }
}
