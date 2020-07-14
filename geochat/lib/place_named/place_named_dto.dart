import 'package:geochat/map/point_dto.dart';
import 'package:geochat/user/user_dto.dart';

class PlaceNamed{
  final String description;
  final User owner;
  final List<Point> fencePoints;

  PlaceNamed({this.description, this.owner, this.fencePoints});
}