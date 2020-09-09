import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/user/user.dart';

class PlaceNamed{
  final String description;
  final User owner;
  final List<Point> fencePoints;

  PlaceNamed({this.description, this.owner, this.fencePoints});
}