
import 'package:in_a_bottle/adapters/location/point.dart';

abstract class GeoLocation {
  Future<Point> loadCurrentPosition();
}
