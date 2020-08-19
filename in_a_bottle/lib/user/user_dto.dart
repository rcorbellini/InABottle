import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String password;
  final String email;
  final String cellphone;
  final String photoUrl;

  const User({
    this.name,
    this.password,
    this.email,
    this.cellphone,
    this.photoUrl,
  });

  User copyWith({
    String name,
    String password,
    String email,
    String cellphone,
    String photoUrl,
  }) {
    return User(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      cellphone: cellphone ?? this.cellphone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
      'email': email,
      'cellphone': cellphone,
      'photoUrl': photoUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      cellphone: map['cellphone'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

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
    ];
  }
}
