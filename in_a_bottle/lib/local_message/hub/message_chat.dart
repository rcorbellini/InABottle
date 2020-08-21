import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class MessageChat extends Equatable implements EntityReactable {
  final User user;
  final String text;
  final String status;
  final DateTime createdAt;
  @override
  final Set<UserReaction> reactions;

  const MessageChat(
      {this.user,
      this.text,
      this.status,
      this.createdAt,
      this.reactions = const <UserReaction>{}});

  MessageChat copyWith({
    User user,
    String text,
    String status,
    DateTime createdAt,
    Set<UserReaction> reactions,
  }) {
    return MessageChat(
      user: user ?? this.user,
      text: text ?? this.text,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      reactions: reactions ?? this.reactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'text': text,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'reactions': reactions?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory MessageChat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MessageChat(
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      text: map['text'] as String,
      status: map['status'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      reactions: Set<UserReaction>.from(
          (map['reactions'] as Iterable<Map<String, dynamic>>)
              ?.map<UserReaction>(
                  (Map<String, dynamic> x) => UserReaction.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageChat.fromJson(String source) =>
      MessageChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      user,
      text,
      status,
      createdAt,
      reactions,
    ];
  }
}

enum Status { sending }
