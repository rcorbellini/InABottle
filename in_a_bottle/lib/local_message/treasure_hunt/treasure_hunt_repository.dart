import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_storage.dart';

abstract class TreasureHuntRepository
    extends BaseRepository<TreasureHunt, String, TreasureHuntStorage> {
  Future<List<TreasureHunt>> loadByLocation(Point location);
}

class TreasureHuntDataRepository extends TreasureHuntRepository {
  @override
  final TreasureHuntStorage dao;
  @override
  final TreasureHuntStorage http;

  TreasureHuntDataRepository(this.dao, this.http);

  @override
  Future<List<TreasureHunt>> loadByLocation(Point location) async {
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
