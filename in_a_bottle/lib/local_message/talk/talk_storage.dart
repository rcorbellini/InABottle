
import 'package:in_a_bottle/_shared/archtecture/base_dao.dart';
import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';

abstract class TalkStorage implements BaseDataStorage<Talk, String> {}

class TalkDao extends BaseDao<Talk> implements TalkStorage {
  @override
  Talk fromJson(map) => Talk.fromMap(map);

  @override
  String get path => "talk";

  @override
  Map<String, dynamic> toJson(Talk entity) => entity.toMap();
}
