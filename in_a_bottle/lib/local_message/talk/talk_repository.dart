import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_storage.dart';

abstract class TalkRepository
    extends BaseRepository<Talk, String, TalkStorage> {
  Future<List<Talk>> loadByLocation(Point location);
}

class TalkDataRepository extends TalkRepository {
  @override
  final TalkStorage dao;
  @override
  final TalkStorage http;

  TalkDataRepository(this.dao, this.http);

  @override
  Future<List<Talk>> loadByLocation(Point location) async {
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
