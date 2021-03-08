import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/features/treasure/presentation/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user.dart';
import 'package:uuid/uuid.dart';

class DirectMessage extends Equatable implements HomeFeed, BaseModel {
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
  final Message message;
  DirectMessage({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.message,
  });

  DirectMessage copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    Message message,
  }) {
    return DirectMessage(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'createdBy': createdBy?.email,
      'latitude': createdOn?.point?.latitude,
      'longitude': createdOn?.point?.longitude,
      'reach': createdOn?.reach?.value,
      'password': createdOn?.password,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'status': status,
      'text': message?.text,
      'title': message?.title,
    };
  }

  factory DirectMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DirectMessage(
      selector: map['selector'],
      createdBy: User(email: map['createdBy']),
      createdOn: Local(point: Point(latitude: map['latitude'], longitude :  map['longitude']), password:  map['password']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'],
      message: Message(title: map['title'], text: map['text'], reactions: map['reactions']??<UserReaction>{} ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectMessage.fromJson(String source) =>
      DirectMessage.fromMap(json.decode(source));

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
      message,
    ];
  }
}
