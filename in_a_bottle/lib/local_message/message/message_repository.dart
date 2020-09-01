import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/message/message_storage.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';

abstract class MessageRepository implements BaseRepository<Message, String> {
  Future<List<Message>> loadAllByLocation(Point location);
}

class MessageDataRepository extends MessageRepository {
  final MessageStorage dao;

  MessageDataRepository(this.dao);

  @override
  Future<List<Message>> loadAll() async {
    return dao.loadAll();
  }

  @override
  Future<List<Message>> loadAllByLocation(Point location) async {
    final entities = await dao.loadAll();
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
    final entity = await dao.loadByKey(key);
    final reactions = entity.reactions?.map((userReaction) {
          int amount = entity.reactions
              .where((r) => r.reaction == userReaction.reaction)
              .length;
          return userReaction.copyWith(
              reaction: userReaction.reaction.copyWith(amount: amount));
        })?.toSet() ??
        {};

    return entity.copyWith(reactions: reactions);
  }

  @override
  Future delete(String key) {
    return dao.delete(key);
  }

  @override
  Future save(Message entity) async {
    if (entity.selector == null) {
      return dao.insert(entity);
    } else {
      return dao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<Message> entities) {
    return dao.saveAll(entities);
  }
}
