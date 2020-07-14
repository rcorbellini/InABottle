import 'package:geochat/map/point_dto.dart';

class Local {
  final Point point;
  final String password;
  final Reach reach;

  Local({this.point, this.password, this.reach});
}


class Reach{
  final String descricao;

  Reach({this.descricao});
}

