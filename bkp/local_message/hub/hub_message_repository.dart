import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_storage.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

abstract class HubMessageRepository
    extends BaseRepository<HubMessage, String, HubMessageStorage> {
  Future<List<HubMessage>> loadByLocation(Point location);

  Future addMessage(String hubKey, Message entity);
  Future addReaction(String hubKey, String messageKey, UserReaction entity);
  Future removeReaction(String hubKey, String messageKey, UserReaction entity);
  
}

class HubMesageDataRepository extends HubMessageRepository {
  @override
  final HubMessageStorage dao;

  @override
  final HubMessageStorage http;

  HubMesageDataRepository(this.dao, this.http);

  @override
  Future<List<HubMessage>> loadByLocation(Point location) async {
    final all = await http.loadAll();
    return all.where((element) {
      if (element?.createdOn?.point == null) {
        return false;
      }

      final distance = location.distanceOf(element.createdOn.point);
      final allowed = element.createdOn.reach?.ditanceAllowed ?? 50;

      return distance < allowed;
    }).toList();
  }

  Future addMessage(String hubKey, Message entity) {
    return http.addMessage(hubKey, entity);
  }

  Future addReaction(String hubKey, String messageKey, UserReaction entity) =>
      http.addReaction(hubKey, messageKey, entity);
  

  Future removeReaction(String hubKey, String messageKey, UserReaction entity) =>
      http.removeReaction(hubKey, messageKey, entity);
}
