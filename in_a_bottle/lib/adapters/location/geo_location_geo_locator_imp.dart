import 'package:geolocator/geolocator.dart';
import 'package:in_a_bottle/adapters/location/geo_location.dart';
import 'package:in_a_bottle/adapters/location/point.dart';

class GeoLocationImp implements GeoLocation {
  @override
  Future<Point> loadCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Point(latitude: position.latitude, longitude: position.longitude);
  }
}
