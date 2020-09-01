import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:in_a_bottle/_shared/archtecture/base_model.dart';

import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Message extends Equatable
    implements HomeFeed, BaseModel, EntityReactable {
  final String selector;
  final String text;
  final String title;
  final User owner;
  final Local local;
  @override
  final Set<UserReaction> reactions;

  Message({
    this.selector,
    this.text,
    this.title,
    this.owner,
    this.local,
    this.reactions = const <UserReaction>{},
  });

  Message copyWith({
    String selector,
    String text,
    String title,
    User owner,
    Local local,
    Set<UserReaction> reactions,
  }) {
    return Message(
      selector: selector ?? this.selector,
      text: text ?? this.text,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      local: local ?? this.local,
      reactions: reactions ?? this.reactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'text': text,
      'title': title,
      'owner': owner?.toMap(),
      'local': local?.toMap(),
      'reactions': reactions?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      selector: map['selector']?.toString(),
      text: map['text'],
      title: map['title'],
      owner: User.fromMap(map['owner']),
      local: Local.fromMap(map['local']),
      reactions: Set<UserReaction>.from(
          map['reactions']?.map((x) => UserReaction.fromMap(x)) ?? []),
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
      owner,
      local,
      reactions,
    ];
  }

  @override
  String toString() {
    return 'Message(selector: $selector, text: $text, title: $title, owner: $owner, local: $local, reactions: $reactions)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message &&
        o.selector == selector &&
        o.text == text &&
        o.title == title &&
        o.owner == owner &&
        o.local == local &&
        setEquals(o.reactions, reactions);
  }

  @override
  int get hashCode {
    return selector.hashCode ^
        text.hashCode ^
        title.hashCode ^
        owner.hashCode ^
        local.hashCode ^
        reactions.hashCode;
  }
}
