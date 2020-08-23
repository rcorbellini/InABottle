import 'dart:convert';

import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Message implements HomeFeed, EntityReactable {
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
    return <String, dynamic>{
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
      selector: map['selector'] as String,
      text: map['text'] as String,
      title: map['title'] as String,
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      local: Local.fromMap(map['local'] as Map<String, dynamic>),
      reactions: Set<UserReaction>.from(
          (map['reactions'] as Iterable<Map<String, dynamic>>)
              ?.map<UserReaction>(
                  (Map<String, dynamic> x) => UserReaction.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

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
}
