import 'package:in_a_bottle/_shared/archtecture/base_data_storage.dart';
import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_storage.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/_shared/location/point.dart';

abstract class DirectMessageRepository
    extends BaseRepository<DirectMessage, String, DirectMessageStorage> {
  Future<List<DirectMessage>> loadByLocation(Point location);
}

class DirectMessageDataRepository extends DirectMessageRepository {
  @override
  final DirectMessageStorage dao;
  @override
  final DirectMessageStorage http;

  DirectMessageDataRepository(this.dao, this.http);

  @override
  Future<List<DirectMessage>> loadByLocation(Point location) async{
    final entities = await dao.loadAll();
    return entities.where((element) {
      if (element?.createdOn?.point == null) {
        return false;
      }
      final distance = location.distanceOf(element.createdOn.point);
      final allowed = element.createdOn.reach?.ditanceAllowed ?? 50;

      return distance < allowed;
    }).toList();

    //yield await http.loadAll();
  }
}
