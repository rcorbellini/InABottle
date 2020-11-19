import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fancy_factory/fancy_factory.dart';

import 'package:in_a_bottle/_shared/location/point.dart';

class Local extends Equatable {
  final Point point;
  final String password;
  final Reach reach;
  final bool isLocked;
  final bool isPrivateDM;
  final List<Tag> tags;

  const Local({
    this.point,
    this.password,
    this.reach,
    this.isLocked = true,
    this.isPrivateDM = false,
    this.tags = const [],
  });

  bool get contentLock => isPrivateDM && isLocked;


  Local copyWith({
    Point point,
    String password,
    Reach reach,
    bool isLocked,
    bool isPrivateDM,
    List<Tag> tags,
  }) {
    return Local(
      point: point ?? this.point,
      password: password ?? this.password,
      reach: reach ?? this.reach,
      isLocked: isLocked ?? this.isLocked,
      isPrivateDM: isPrivateDM ?? this.isPrivateDM,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'point': point?.toMap(),
      'password': password,
      'reach': reach?.toMap(),
      'isLocked': isLocked,
      'isPrivateDM': isPrivateDM,
      'tags': tags?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Local.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Local(
      point: Point.fromMap(map['point']),
      password: map['password'],
      reach: Reach.fromMap(map['reach']),
      isLocked: map['isLocked'],
      isPrivateDM: map['isPrivateDM'],
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))??[]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Local.fromJson(String source) => Local.fromMap(json.decode(source));

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
      tags,
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

  int get ditanceAllowed => value == 0 ? 50 : value == 1 ? 100 : 150;

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
      //'descricao': descricao,
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
