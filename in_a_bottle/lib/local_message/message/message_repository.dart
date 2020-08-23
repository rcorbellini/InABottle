import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/user/user_dto.dart';

abstract class MessageRepository
    implements BaseRepository<Message, String> {}

class MessageDataRepository extends MessageRepository {
  static final memory = <Message>[
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        text: "De buenas?",
        title: "Hmmm No Title",
        owner: User(
            name: "Rafael Corbellini",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c")),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        owner: User(
            name: "Rc",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
        text: "blabla",
        title: "Title Ba"),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        owner: User(
            name: "Rc",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
        text: "blabla",
        title: "Title Ba"),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        owner: User(
            name: "Rc",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
        text: "blabla",
        title: "Title Ba"),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        text: "blabla",
        title: "Title Ba"),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        owner: User(
            name: "Rc",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
        text: "blabla",
        title: "Title Ba"),
    Message(
        local: Local(
          point: Point(latitude: 10, longitude: 10),
        ),
        owner: User(
            name: "Rc",
            photoUrl:
                "https://lh3.googleusercontent.com/a-/AOh14GjoxZnVNWM7gOM9SE1Ru8ItjltX7iw5QT2809l8sn0=s96-c"),
        text: "blabla",
        title: "Title Ba"),
    Message(
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
  Future<List<Message>> loadAll() async {
    return memory;
  }

  @override
  Future<Message> loadByKey(String key) async {
    final entity = memory[0];
    final reactions = entity.reactions.map((userReaction) {
      int amount = entity.reactions
          .where((r) => r.reaction == userReaction.reaction)
          .length;
      return userReaction.copyWith(
          reaction: userReaction.reaction.copyWith(amount: amount));
    }).toSet();

    return entity.copyWith(reactions: reactions);
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future save(Message entity) async {
    memory[0] = entity;
  }

  @override
  Future saveAll(Iterable<Message> entities) {
    // TODO: implement saveAll
    return null;
  }
}
