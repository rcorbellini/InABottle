import 'package:in_a_bottle/adapters/archtecture/base_model.dart';
import 'package:in_a_bottle/common/storage/app_database.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

abstract class BaseDao<T extends BaseModel> {
  StoreRef get _folder => stringMapStoreFactory.store(path);

  Future<Database> get _db => AppDatabase.instance.database;

  String get newKey => Uuid().v4();

  Future delete(String key) async {
    _folder.record(key).delete(await _db);
  }

  Future<String> insert(T entity) async {
    return await _folder.record(newKey).add(await _db, toJson(entity));
  }

  Future<List<T>> loadAll() async {
    final snapshots = await _folder.find(await _db);
    return snapshots
        .map((snapshot) => fromJson(coppyWithKey(snapshot.key, snapshot.value)))
        .toList();
  }

  Future<T> loadByKey(String key) async {
    final snapshot = await _folder.record(key).get(await _db);
    return fromJson(coppyWithKey(key, snapshot));
  }

  Future saveAll(Iterable<T> entities) async {
    await (await _db).transaction((txn) async {
      await Future.forEach(entities, (T entity) => _folder.add(txn, toJson(entity)));
    });
  }

  Future update(String key, T entity) async {
    return _folder.record(key).update(await _db, toJson(entity));
  }

  Map<String, dynamic> coppyWithKey(dynamic key, dynamic dbMap) {
    final map = Map<String, dynamic>.from(dbMap);
    map['selector'] = key;
    return map;
  }

  T fromJson(dynamic map);

  Map<String, dynamic> toJson(T entity);

  String get path;
}