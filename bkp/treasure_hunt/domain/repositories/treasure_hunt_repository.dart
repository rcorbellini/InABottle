
import 'package:in_a_bottle/adapters/archtecture/base_repository.dart';
import 'package:in_a_bottle/adapters/location/point.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/data_sources/treasure_hunt_storage.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/treasure_hunt.dart';

abstract class TreasureHuntRepository
    extends BaseRepository<TreasureHunt, String, TreasureHuntStorage> {
  Future<List<TreasureHunt>> loadByLocation(Point location);
}