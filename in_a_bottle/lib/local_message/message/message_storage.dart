import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';

abstract class MessageStorage implements BaseDataStorage<Message, String> {}

class MessageDao extends BaseDao<Message> implements MessageStorage {
  @override
  Message fromJson(map) => Message.fromMap(map);

  @override
  String get path => "message";

  @override
  Map<String, dynamic> toJson(Message entity) => entity.toMap();
}
