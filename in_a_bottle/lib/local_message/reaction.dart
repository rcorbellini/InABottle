import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Reaction extends Equatable {
  final User createdBy;
  final String reaction;

  //screen elements
  final int amount;

  const Reaction({
    this.createdBy,
    this.reaction,
    this.amount
  });

  Reaction copyWith({
    User createdBy,
    String reaction,
    int amount,
  }) {
    return Reaction(
      createdBy: createdBy ?? this.createdBy,
      reaction: reaction ?? this.reaction,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'reaction': reaction,
    };
  }

  factory Reaction.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Reaction(
      createdBy: map['createdBy'] as User,
      reaction: map['reaction'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reaction.fromJson(String source) =>
      Reaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [createdBy, reaction];
}
