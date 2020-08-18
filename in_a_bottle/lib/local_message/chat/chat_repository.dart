import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/chat/chat.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';

abstract class ChatRepository implements BaseRepository<Chat, String> {}

class ChatDataRepository extends ChatRepository {
  static final memory = <Chat>[
    Chat(
        title: "teste password",
        local: Local( 
            point: Point(latitude: 10, longitude: 10),
            password: "123",
            isPrivateDM: true,
            isLocked: true, 
            reach: Reach(value: 1)))
  ];
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<Chat>> loadAll() async{
    return memory;
  }

  @override
  Future<Chat> loadByKey(String key) async {
    return memory[0];
  }

  @override
  Future save(Chat entity) {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll(Iterable<Chat> entities) {
    // TODO: implement saveAll
    return null;
  }
}
