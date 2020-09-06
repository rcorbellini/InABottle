import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/talk/talk.dart';
import 'package:in_a_bottle/local_message/talk/talk_storage.dart';

abstract class TalkRepository
    extends BaseRepository<Talk, String, TalkStorage> {
  Future<List<Talk>> loadAllByLocation(Point location);
}

class TalkDataRepository extends TalkRepository {
  @override
  final TalkStorage dao;
  @override
  final TalkStorage http;

  TalkDataRepository(this.dao, this.http);

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
}
