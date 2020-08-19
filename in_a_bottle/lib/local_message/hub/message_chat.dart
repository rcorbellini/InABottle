import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/user/user_dto.dart';

class MessageChat extends Equatable {
  final User user;
  final String text;
  final String status;
  final DateTime createdAt;

  const MessageChat({
    this.user,
    this.text,
    this.status,
    this.createdAt,
  });

  MessageChat copyWith({
    User user,
    String text,
    String status,
    DateTime createdAt,
  }) {
    return MessageChat(
      user: user ?? this.user,
      text: text ?? this.text,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'text': text,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MessageChat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MessageChat(
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      text: map['text'] as String,
      status: map['status'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageChat.fromJson(String source) =>
      MessageChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [user, text, status, createdAt];
}


enum Status{
  sending
}