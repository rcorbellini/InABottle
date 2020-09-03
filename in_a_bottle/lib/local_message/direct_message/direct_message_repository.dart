import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_storage.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/_shared/location/point.dart';

abstract class DirectMessageRepository
    implements BaseRepository<DirectMessage, String> {
  Future<List<DirectMessage>> loadAllByLocation(Point location);
}

class DirectMessageDataRepository extends DirectMessageRepository {
  final DirectMessageStorage dao;

  DirectMessageDataRepository(this.dao);

  @override
  Future<List<DirectMessage>> loadAll() async {
    return dao.loadAll();
  }

  @override
  Future<List<DirectMessage>> loadAllByLocation(Point location) async {
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
  Future<DirectMessage> loadByKey(String key) async {
    final entity = await dao.loadByKey(key);
    final reactions = entity.message?.reactions?.map(
          (userReaction) {
            int amount = entity.message.reactions
                .where((r) => r.reaction == userReaction.reaction)
                .length;
            return userReaction.copyWith(
              reaction: userReaction.reaction.copyWith(amount: amount),
            );
          },
        )?.toSet() ??
        {};

    return entity.copyWith(message: entity.message?.copyWith(reactions: reactions));
  }

  @override
  Future delete(String key) {
    return dao.delete(key);
  }

  @override
  Future save(DirectMessage entity) async {
    if (entity.selector == null) {
      return dao.insert(entity);
    } else {
      return dao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<DirectMessage> entities) {
    return dao.saveAll(entities);
  }
}
