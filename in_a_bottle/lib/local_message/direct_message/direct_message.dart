import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/message/message.dart';

class DirectMessage extends Equatable implements HomeFeed, BaseModel {
  final Local local;
  final Message message;
  final String selector;
  DirectMessage({
    this.local,
    this.message,
    this.selector,
  });

  DirectMessage copyWith({
    Local local,
    Message message,
    String selector,
  }) {
    return DirectMessage(
      local: local ?? this.local,
      message: message ?? this.message,
      selector: selector ?? this.selector,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'local': local?.toMap(),
      'message': message?.toMap(),
      'selector': selector,
    };
  }

  factory DirectMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DirectMessage(
      local: Local.fromMap(map['local']),
      message: Message.fromMap(map['message']),
      selector: map['selector'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectMessage.fromJson(String source) =>
      DirectMessage.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [local, message, selector];
}
