import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';

abstract class DirectMessageStorage implements BaseDataStorage<DirectMessage, String> {}

class DirectMessageDao extends BaseDao<DirectMessage> implements DirectMessageStorage {
  @override
  DirectMessage fromJson(map) => DirectMessage.fromMap(map);

  @override
  String get path => "message";

  @override
  Map<String, dynamic> toJson(DirectMessage entity) => entity.toMap();
}
