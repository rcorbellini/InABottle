import 'package:geochat/local_message/local/local_dto.dart';
import 'package:geochat/map/point_dto.dart';

abstract class HomeEvent{
}

class AddLocal extends HomeEvent{
  final TypeLocal type;

  AddLocal(this.type);
}

class LoadByPosition{
  final Point point;

  LoadByPosition(this.point);
}