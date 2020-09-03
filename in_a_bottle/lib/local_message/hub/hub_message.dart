import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class HubMessage extends Equatable implements BaseModel, HomeFeed {
  final String selector;
  final Local local;
  final List<User> admin;
  final String title;
  final User createdBy;
  final List<Message> messageChat;

  HubMessage({
    this.selector,
    this.local,
    this.admin,
    this.title,
    this.createdBy,
    this.messageChat,
  });

  HubMessage copyWith({
    String selector,
    Local local,
    List<User> admin,
    String title,
    User createdBy,
    List<Message> messageChat,
  }) {
    return HubMessage(
      selector: selector ?? this.selector,
      local: local ?? this.local,
      admin: admin ?? this.admin,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      messageChat: messageChat ?? this.messageChat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'local': local?.toMap(),
      'admin': admin?.map((x) => x?.toMap())?.toList(),
      'title': title,
      'createdBy': createdBy?.toMap(),
      'messageChat': messageChat?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory HubMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return HubMessage(
      selector: map['selector'],
      local: Local.fromMap(map['local']),
      admin: List<User>.from(map['admin']?.map((x) => User.fromMap(x))),
      title: map['title'],
      createdBy: User.fromMap(map['createdBy']),
      messageChat: List<Message>.from(map['messageChat']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HubMessage.fromJson(String source) => HubMessage.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      selector,
      local,
      admin,
      title,
      createdBy,
      messageChat,
    ];
  }
}
