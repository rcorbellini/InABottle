import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/direct_message_dto.dart';
import 'package:in_a_bottle/location/point_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

abstract class MessageRepository
    implements BaseRepository<DirectMessage, String> {}

class MessageDataRepository extends MessageRepository {
  static final memory = <DirectMessage>[
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          text: "De buenas?",
          title: "Hmmm No Title",
          owner: User(
              name: "Rafael Corbellini",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c")),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
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
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
          text: "blabla",
          title: "Title Ba"),
      DirectMessage(
          local: Local(
            point: Point(latitude: 10, longitude: 10),
          ),
          owner: User(
              name: "Rc",
              photoUrl:
                  "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
          text: "blabla",
          title: "Title Ba"),
    ];
  @override
  Future<List<DirectMessage>> loadAll() async {
    return memory;
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
  Future save(DirectMessage entity) async {
     memory.add(entity);
  }

  @override
  Future saveAll(Iterable<DirectMessage> entities) {
    // TODO: implement saveAll
    return null;
  }
}
