import 'package:in_a_bottle/_shared/location/point_dto.dart';

class Local {
  final Point point;
  final String password;
  final Reach reach;
  final TypeLocal type;

  Local({this.point, this.password, this.reach, this.type});
}


class Reach{
  final String descricao;
  final double value;

  Reach({this.descricao, this.value});
}


class TypeLocal{

}