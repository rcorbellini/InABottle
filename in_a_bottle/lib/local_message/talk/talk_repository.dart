import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_storage.dart';

abstract class TalkRepository extends BaseRepository<Talk, String> {
  Future<List<Talk>> loadAllByLocation(Point location);
}

class TalkDataRepository implements TalkRepository {
  final TalkStorage dao;

  TalkDataRepository(this.dao);

  @override
  Future<List<Talk>> loadAll() => dao.loadAll();

  @override
  Future<List<Talk>> loadAllByLocation(Point location) async {
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
  Future delete(String key) => dao.delete(key);

  @override
  Future<Talk> loadByKey(String key) async {
    final entity = await dao.loadByKey(key);
    final openMessage = entity.openMessage.map((message) {
      final reactions = message.reactions.map((userReaction) {
        int amount = message.reactions
            .where((r) => r.reaction == userReaction.reaction)
            .length;
        return userReaction.copyWith(
            reaction: userReaction.reaction.copyWith(amount: amount));
      }).toSet();

      return message.copyWith(reactions: reactions);
    }).toList();

    final closeMessage = entity.closeMessage.map((message) {
      final reactions = message.reactions.map((userReaction) {
        int amount = message.reactions
            .where((r) => r.reaction == userReaction.reaction)
            .length;
        return userReaction.copyWith(
            reaction: userReaction.reaction.copyWith(amount: amount));
      }).toSet();

      return message.copyWith(reactions: reactions);
    }).toList();

    return entity.copyWith(
        openMessage: openMessage, closeMessage: closeMessage);
  }

  @override
  Future save(Talk entity) async {
    if (entity.selector == null) {
      return dao.insert(entity);
    } else {
      return dao.update(entity);
    }
  }

  @override
  Future saveAll(Iterable<Talk> entities) => dao.saveAll(entities);
}
