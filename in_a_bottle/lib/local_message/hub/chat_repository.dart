import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/hub/chat.dart';
import 'package:in_a_bottle/local_message/hub/chat_message.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';

abstract class ChatRepository implements BaseRepository<Chat, String> {
  Future<List<Chat>> loadAllByLocation(Point location);
}

class ChatDataRepository extends ChatRepository {
  static final memory = <Chat>[
    Chat(
        title: "teste password",
        messageChat: const [
          ChatMessage(text: "texto de teste 1"),
          ChatMessage(text: "texto de teste 2")
        ],
        local: const Local(
            point: Point(latitude: 0, longitude: 0),
            password: "123",
            isPrivateDM: true,
            isLocked: true,
            reach: Reach(value: 1)))
  ];
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<Chat>> loadAll() async {
    return memory;
  }

  @override
  Future<List<Chat>> loadAllByLocation(Point location) async {
    return memory.where((element) {
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
    final chat = memory[0];
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
  Future save(Chat entity) async {
    return memory[0] = entity;
  }

  @override
  Future saveAll(Iterable<Chat> entities) {
    // TODO: implement saveAll
    return null;
  }
}
