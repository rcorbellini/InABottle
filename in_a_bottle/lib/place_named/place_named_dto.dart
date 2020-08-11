import 'package:in_a_bottle/location/point_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class PlaceNamed{
  final String description;
  final User owner;
  final List<Point> fencePoints;

  PlaceNamed({this.description, this.owner, this.fencePoints});
}