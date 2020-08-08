import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/map/point_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

abstract class MessageRepository
    implements BaseRepository<DirectMessage, String> {}

class MessageDataRepository extends MessageRepository {
  @override
  Future<List<DirectMessage>> loadAll() async {
    return [
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba",
          owner: User(name: "Tester")),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "blabla",
          title: "Title Ba"),
    ];
  }

  @override
  Future<DirectMessage> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future save(DirectMessage entity) {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll(Iterable<DirectMessage> entities) {
    // TODO: implement saveAll
    return null;
  }
}
