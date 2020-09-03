
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';

abstract class HubMessageStorage implements BaseDataStorage<HubMessage, String> {}

class HubMessageDao extends BaseDao<HubMessage> implements HubMessageStorage {
  @override
  HubMessage fromJson(map) => HubMessage.fromMap(map);

  @override
  String get path => "chat";

  @override
  Map<String, dynamic> toJson(HubMessage entity) => entity.toMap();
}
