
import 'package:in_a_bottle/adapters/archtecture/base_repository.dart';
import 'package:in_a_bottle/adapters/location/point.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/models/treasure_hunt.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_storage.dart';

abstract class TreasureHuntRepository
    extends BaseRepository<TreasureHunt, String, TreasureHuntStorage> {
  Future<List<TreasureHunt>> loadByLocation(Point location);
}