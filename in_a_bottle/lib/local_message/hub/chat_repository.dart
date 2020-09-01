import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/chat_storage.dart';

abstract class ChatRepository implements BaseRepository<Chat, String> {
  Future<List<Chat>> loadAllByLocation(Point location);
}

class ChatDataRepository implements ChatRepository {
  final ChatStorage dao;

  ChatDataRepository(this.dao);

  @override
  Future delete(String key) => dao.delete(key);

  @override
  Future<List<Chat>> loadAll() => dao.loadAll();

  @override
  Future<List<Chat>> loadAllByLocation(Point location) async {
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
  Future<Chat> loadByKey(String key) async {
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
  Future save(Chat entity) {
    if (entity.selector == null) {
      return dao.insert(entity);
    } else {
      return dao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<Chat> entities) {
    return dao.saveAll(entities);
  }
}
