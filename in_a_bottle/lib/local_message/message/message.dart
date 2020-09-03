import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Message extends Equatable implements BaseModel, EntityReactable {
  final String selector;
  final String text;
  final String title;
  final Set<UserReaction> reactions;
  final String status;

  final User createdBy;
  final DateTime createdAt;
  Message({
    this.selector,
    this.text,
    this.title,
    this.reactions,
    this.status,
    this.createdBy,
    this.createdAt,
  });

  Message copyWith({
    String selector,
    String text,
    String title,
    Set<UserReaction> reactions,
    String status,
    User createdBy,
    DateTime createdAt,
  }) {
    return Message(
      selector: selector ?? this.selector,
      text: text ?? this.text,
      title: title ?? this.title,
      reactions: reactions ?? this.reactions,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'text': text,
      'title': title,
      'reactions': reactions?.map((x) => x?.toMap())?.toList(),
      'status': status,
      'createdBy': createdBy?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      selector: map['selector'],
      text: map['text'],
      title: map['title'],
      reactions: Set<UserReaction>.from(
          map['reactions']?.map((x) => UserReaction.fromMap(x))),
      status: map['status'],
      createdBy: User.fromMap(map['createdBy']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      selector,
      text,
      title,
      reactions,
      status,
      createdBy,
      createdAt,
    ];
  }
}
