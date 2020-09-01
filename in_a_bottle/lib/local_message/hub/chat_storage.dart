
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';

abstract class ChatStorage implements BaseDataStorage<Chat, String> {}

class ChatDao extends BaseDao<Chat> implements ChatStorage {
  @override
  Chat fromJson(map) => Chat.fromMap(map);

  @override
  String get path => "chat";

  @override
  Map<String, dynamic> toJson(Chat entity) => entity.toMap();
}
