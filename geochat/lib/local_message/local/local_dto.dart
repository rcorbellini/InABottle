import 'package:geochat/map/point_dto.dart';

class Local {
  final Point point;
  final String password;
  final Reach reach;
  final TypeLocal type;

  Local({this.point, this.password, this.reach, this.type});
}


class Reach{
  final String descricao;

  Reach({this.descricao});
}


class TypeLocal{

}