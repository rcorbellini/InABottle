import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/common/storage/app_database.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

abstract class MessageStorage extends BaseDataStorage<Message, String> {
  static String get path => "message";
}

class MessageDao extends MessageStorage {
  final StoreRef _folder = stringMapStoreFactory.store(MessageStorage.path);

  Future<Database> get _db async => await AppDatabase.instance.database;

  String get newKey => Uuid().v4();

  @override
  Future delete(String key) async {
    _folder.record(key).delete(await _db);
  }

  @override
  Future insert(Message entity) async {
    await _folder.record(newKey).add(await _db, entity.toMap());
  }

  @override
  Future<Iterable<Message>> loadAll() async {
    final snapshots = await _folder.find(await _db);
    return snapshots
        .map((snapshot) =>
            Message.fromMap(coppyWithKey(snapshot.key, snapshot.value)))
        .toList();
  }

  @override
  Future<Message> loadByKey(String key) async {
    final snapshot = await _folder.record(key).get(await _db);
    return Message.fromMap(coppyWithKey(key, snapshot));
  }

  @override
  Future saveAll(Iterable<Message> entities) async {
    await (await _db).transaction((txn) async {
      await Future.forEach(entities, (e) => _folder.add(txn, e.toMap()));
    });
  }

  @override
  Future update(Message entity) async {
    return _folder.record(entity.selector).update(await _db, entity.toMap());
  }

  Map<String, dynamic> coppyWithKey(dynamic key, dynamic  dbMap) {
    final map = Map<String, dynamic>.from(dbMap);
    map['selector'] = key;
    return map;
  }
}
