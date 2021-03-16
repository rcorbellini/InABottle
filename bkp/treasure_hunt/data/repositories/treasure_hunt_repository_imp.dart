import 'package:in_a_bottle/adapters/location/point.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/data_sources/treasure_hunt_storage.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/treasure_hunt.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/repositories/treasure_hunt_repository.dart';

class TreasureHuntRepositoryImp extends TreasureHuntRepository {
  @override
  final TreasureHuntStorage dao;
  @override
  final TreasureHuntStorage http;

  TreasureHuntRepositoryImp(this.dao, this.http);

  @override
  Future<List<TreasureHunt>> loadByLocation(Point location) async {
    final entities = await http.loadAll();
    return entities.toList();

    //yield await http.loadAll();
  }
}
