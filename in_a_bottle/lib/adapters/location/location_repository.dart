import 'package:geolocator/geolocator.dart';
import 'package:in_a_bottle/adapters/location/point.dart';

abstract class LocationRepository {
  Future<Point> loadCurrentPosition();
}

class LocationDataRepository implements LocationRepository { 

  @override
  Future<Point> loadCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Point(latitude: position.latitude, longitude: position.longitude);
  }
}
