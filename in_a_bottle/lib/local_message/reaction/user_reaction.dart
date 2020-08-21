import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class UserReaction extends Equatable {
  final User createdBy;
  final TypeReaction reaction;


  const UserReaction({
    this.createdBy,
    this.reaction,
  });

  UserReaction copyWith({
    User createdBy,
    TypeReaction reaction,
  }) {
    return UserReaction(
      createdBy: createdBy ?? this.createdBy,
      reaction: reaction ?? this.reaction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy?.toMap(),
      'reaction': reaction?.toMap(),
    };
  }

  factory UserReaction.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserReaction(
      createdBy: User.fromMap(map['createdBy'] as Map<String, dynamic>),
      reaction: TypeReaction.fromMap(map['reaction'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReaction.fromJson(String source) =>
      UserReaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [createdBy, reaction];
}

abstract class EntityReactable {
  Set<UserReaction> get reactions;
}
