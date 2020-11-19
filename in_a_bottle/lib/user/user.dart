import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String password;
  final String email;
  final String cellphone;
  final String photoUrl;
  final int points;

  const User({
    this.name,
    this.password,
    this.email,
    this.cellphone,
    this.photoUrl,
    this.points,
  });

  User copyWith({
    String name,
    String password,
    String email,
    String cellphone,
    String photoUrl,
    int points,
  }) {
    return User(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      cellphone: cellphone ?? this.cellphone,
      photoUrl: photoUrl ?? this.photoUrl,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'name': name,
      //'password': password,
      'email': email,
      //'cellphone': cellphone,
      //'photoUrl': photoUrl,
      //'points': points,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      name: map['name'],
      password: map['password'],
      email: map['email'],
      cellphone: map['cellphone'],
      photoUrl: map['photoUrl'],
      points: map['points'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      password,
      email,
      cellphone,
      photoUrl,
      points,
    ];
  }
}
