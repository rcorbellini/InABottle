import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/message_data_storage.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/user/user_dto.dart';

abstract class MessageRepository implements BaseRepository<Message, String> {
  Future<List<Message>> loadAllByLocation(Point location);
}

class MessageDataRepository extends MessageRepository {
  final MessageDao messageDao = MessageDao();

  static final memoryDep = <Message>[
    Message(
        local: Local(
          point: Point(latitude: 0, longitude: 0),
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
    return messageDao.loadAll();
  }

  @override
  Future<List<Message>> loadAllByLocation(Point location) async {
    final entities = await messageDao.loadAll();
    return entities.where((element) {
      if (element?.local?.point == null) {
        return false;
      }
      final distance = location.distanceOf(element.local.point);
      final allowed = element.local.reach?.ditanceAllowed ?? 50;

      return distance < allowed;
    }).toList();
  }

  @override
  Future<Message> loadByKey(String key) async {
    final entity = await messageDao.loadByKey(key);
    final reactions = entity.reactions?.map((userReaction) {
      int amount = entity.reactions
          .where((r) => r.reaction == userReaction.reaction)
          .length;
      return userReaction.copyWith(
          reaction: userReaction.reaction.copyWith(amount: amount));
    })?.toSet() ?? {};

    return entity.copyWith(reactions: reactions);
  }

  @override
  Future delete(String key) {
    return messageDao.delete(key);
  }

  @override
  Future save(Message entity) async {
    if(entity.selector == null){
      return messageDao.insert(entity);
    }else{
      return messageDao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<Message> entities) {
    return messageDao.saveAll(entities);
  }
}
