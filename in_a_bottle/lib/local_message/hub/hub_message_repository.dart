import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_storage.dart';

abstract class HubMessageRepository implements BaseRepository<HubMessage, String> {
  Future<List<HubMessage>> loadAllByLocation(Point location);
}

class HubMesageDataRepository implements HubMessageRepository {
  final HubMessageStorage dao;

  HubMesageDataRepository(this.dao);

  @override
  Future delete(String key) => dao.delete(key);

  @override
  Future<List<HubMessage>> loadAll() => dao.loadAll();

  @override
  Future<List<HubMessage>> loadAllByLocation(Point location) async {
    final all = await dao.loadAll();
    return all.where((element) {
      if (element?.local?.point == null) {
        return false;
      }

      final distance = location.distanceOf(element.local.point);
      final allowed = element.local.reach?.ditanceAllowed ?? 50;

      return distance < allowed;
    }).toList();
  }

  @override
  Future<HubMessage> loadByKey(String key) async {
    final chat = await dao.loadByKey(key);
    final messages = chat.messageChat.map((message) {
      final reactions = message.reactions.map((userReaction) {
        int amount = message.reactions
            .where((r) => r.reaction == userReaction.reaction)
            .length;
        return userReaction.copyWith(
            reaction: userReaction.reaction.copyWith(amount: amount));
      }).toSet();

      return message.copyWith(reactions: reactions);
    }).toList();

    return chat.copyWith(messageChat: messages);
  }

  @override
  Future save(HubMessage entity) {
    if (entity.selector == null) {
      return dao.insert(entity);
    } else {
      return dao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<HubMessage> entities) {
    return dao.saveAll(entities);
  }
}
