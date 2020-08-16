import 'dart:convert';

import 'package:equatable/equatable.dart';

class Point extends Equatable {
  final double latitude;
  final double longitude;

  const Point({
    this.latitude,
    this.longitude,
  });

  Point copyWith({
    double latitude,
    double longitude,
  }) {
    return Point(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Point(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Point.fromJson(String source) =>
      Point.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [latitude, longitude];
}
