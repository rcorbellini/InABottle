import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/hub/hub_message.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_storage.dart';

abstract class HubMessageRepository
    extends BaseRepository<HubMessage, String, HubMessageStorage> {
  Future<List<HubMessage>> loadAllByLocation(Point location);
}

class HubMesageDataRepository extends HubMessageRepository {
  @override
  final HubMessageStorage dao;

  @override
  final HubMessageStorage http;

  HubMesageDataRepository(this.dao, this.http);

  @override
  Future<List<HubMessage>> loadAllByLocation(Point location) async {
    final all = await dao.loadAll();
    return all.where((element) {
      if (element?.createdOn?.point == null) {
        return false;
      }

      final distance = location.distanceOf(element.createdOn.point);
      final allowed = element.createdOn.reach?.ditanceAllowed ?? 50;

      return distance < allowed;
    }).toList();
  }
}
