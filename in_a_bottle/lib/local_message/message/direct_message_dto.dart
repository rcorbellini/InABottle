import 'dart:convert';

import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class DirectMessage extends HomeFeed {
  final String selector;
  final String text;
  final String title;
  final User owner;
  final Local local;

  DirectMessage({
    this.selector,
    this.text,
    this.title,
    this.owner,
    this.local,
  });

  DirectMessage copyWith({
    String selector,
    String text,
    String title,
    User owner,
    Local local,
  }) {
    return DirectMessage(
      selector: selector ?? this.selector,
      text: text ?? this.text,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selector': selector,
      'text': text,
      'title': title,
      'owner': owner?.toMap(),
      'local': local?.toMap(),
    };
  }

  factory DirectMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DirectMessage(
      selector: map['selector'] as String,
      text: map['text'] as String,
      title: map['title'] as String,
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      local: Local.fromMap(map['local'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectMessage.fromJson(String source) =>
      DirectMessage.fromMap(json.decode(source) as Map<String, dynamic>);

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
    ];
  }
}
