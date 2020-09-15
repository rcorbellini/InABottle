import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user.dart';

class Message extends Equatable implements BaseModel, EntityReactable {
   //Base
  @override
  final String selector;
  @override
  final User createdBy;
  @override
  final Local createdOn;
  @override
  final DateTime createdAt;
  @override
  final String status;
  
  //Entity
  final String text;
  final String title;
  final Set<UserReaction> reactions;

  Message({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.text,
    this.title,
    this.reactions,
  });

  Message copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    String text,
    String title,
    Set<UserReaction> reactions,
  }) {
    return Message(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      text: text ?? this.text,
      title: title ?? this.title,
      reactions: reactions ?? this.reactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'createdBy': createdBy?.toMap(),
      'createdOn': createdOn?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'status': status,
      'text': text,
      'title': title,
      'reactions': reactions?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Message(
      selector: map['selector'],
      createdBy: User.fromMap(map['createdBy']),
      createdOn: Local.fromMap(map['createdOn']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']?? DateTime.now().millisecondsSinceEpoch),
      status: map['status'],
      text: map['text'],
      title: map['title'],
      reactions: Set<UserReaction>.from(map['reactions']?.map((x) => UserReaction.fromMap(x))??{}),
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
      createdBy,
      createdOn,
      createdAt,
      status,
      text,
      title,
      reactions,
    ];
  }
}
