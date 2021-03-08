import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/features/treasure/presentation/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/user/user.dart';

class HubMessage extends Equatable implements BaseModel, HomeFeed {
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
  final List<User> admin;
  final String title;
  final List<Message> messageChat;

  HubMessage({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.admin,
    this.title,
    this.messageChat,
  });

  HubMessage copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    List<User> admin,
    String title,
    List<Message> messageChat,
  }) {
    return HubMessage(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      admin: admin ?? this.admin,
      title: title ?? this.title,
      messageChat: messageChat ?? this.messageChat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'createdBy': createdBy?.email,
      'createdAt': createdAt?.millisecondsSinceEpoch, 
      'latitude': createdOn?.point?.latitude,
      'longitude': createdOn?.point?.longitude,
      'reach': createdOn?.reach?.value,
      'status': status,
      'admin': admin?.map((x) => x?.email)?.toList(),
      'title': title,
    };
  }

  factory HubMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HubMessage(
      selector: map['selector'],
      createdBy: User(email: map['createdBy']),
      createdOn: Local(point: Point(latitude: map['latitude'], longitude :  map['longitude']), password:  map['password']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'],
      admin: List<User>.from(map['admin']?.map((x) => User(email: x))??[]),
      title: map['title'],
      messageChat: List<Message>.from(
          map['messageChat']?.map((x) => Message.fromMap(x))??[]),
    );
  }

  String toJson() => json.encode(toMap());

  factory HubMessage.fromJson(String source) =>
      HubMessage.fromMap(json.decode(source));

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
      admin,
      title,
      messageChat,
    ];
  }
}
