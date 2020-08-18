import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/location/point.dart';

class Local extends Equatable {
  final Point point;
  final String password;
  final Reach reach;
  final bool _isLocked;
  final bool isPrivateDM;

  const Local({
    this.point,
    this.password,
    this.reach,
    bool isLocked = true,
    this.isPrivateDM = false,
  }) : _isLocked = isLocked;

  bool get isLocked => isPrivateDM && _isLocked;

  Local copyWith({
    Point point,
    String password,
    Reach reach,
    bool isLocked,
    bool isPrivateDM,
  }) {
    return Local(
      point: point ?? this.point,
      password: password ?? this.password,
      reach: reach ?? this.reach,
      isLocked: isLocked ?? this.isLocked,
      isPrivateDM: isPrivateDM ?? this.isPrivateDM,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'point': point?.toMap(),
      'password': password,
      'reach': reach?.toMap(),
      'isLocked': isLocked,
      'isPrivateDM': isPrivateDM,
    };
  }

  factory Local.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Local(
      point: Point.fromMap(map['point'] as Map<String, dynamic>),
      password: map['password'] as String,
      reach: Reach.fromMap(map['reach'] as Map<String, dynamic>),
      isLocked: map['isLocked'] as bool,
      isPrivateDM: map['isPrivateDM'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Local.fromJson(String source) =>
      Local.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      point,
      password,
      reach,
      isLocked,
      isPrivateDM,
    ];
  }
}

class Reach extends Equatable {
  final String descricao;
  final double value;

  const Reach({
    this.descricao,
    this.value,
  });

  @override
  List<Object> get props => [descricao, value];

  Reach copyWith({
    String descricao,
    double value,
  }) {
    return Reach(
      descricao: descricao ?? this.descricao,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': descricao,
      'value': value,
    };
  }

  factory Reach.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Reach(
      descricao: map['descricao'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reach.fromJson(String source) =>
      Reach.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
