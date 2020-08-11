import 'package:in_a_bottle/_shared/archtecture/base_repository.dart';
import 'package:in_a_bottle/location/point_dto.dart';

abstract class LocationRepository{
  Future<Point> loadCurrentPosition();
}

class LocationDataRepository implements BaseRepository<Point, String>, LocationRepository{
  @override
  Future delete(String key) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<Point>> loadAll() {
    // TODO: implement loadAll
    return null;
  }

  @override
  Future<Point> loadByKey(String key) {
    // TODO: implement loadByKey
    return null;
  }

  @override
  Future save(Point entity) {
    // TODO: implement save
    return null;
  }

  @override
  Future saveAll(Iterable<Point> entities) {
    // TODO: implement saveAll
    return null;
  }

  @override
  Future<Point> loadCurrentPosition() {
    // TODO: implement loadCurrentPosition
    return null;
  }

}