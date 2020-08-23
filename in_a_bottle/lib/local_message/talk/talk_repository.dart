import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_model.dart';

abstract class TalkRepository extends BaseRepository<Talk, String> {}

class TalkDataRepository implements TalkRepository {
  static final memory = [
    Talk(
      title: "teste",
      local: Local(
        isLocked: false,
        isPrivateDM: false,
        point: Point(
          latitude: 1,
          longitude: 2,
        ),
        reach: Reach(
          descricao: 'a',
          value: 1,
        ),
      ),
      openMessage: [
        TalkMessage(text: "bla"),
      ],
      closeMessage: [
        TalkMessage(text: "blu"),
      ],
    ),
    Talk(title: "teste1"),
    Talk(title: "teste2"),
    Talk(title: "teste3"),
    Talk(title: "teste4")
  ];
  @override
  Future<List<Talk>> loadAll() async {
    return memory;
  }

  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Talk> loadByKey(String key) async {
    final entity = memory[0];
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
    memory[0] = entity;
  }

  @override
  Future saveAll(Iterable<Talk> entities) {
    // TODO: implement saveAll
    return null;
  }
}
