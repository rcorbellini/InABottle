import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/_shared/location/point.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user.dart';

class TreasureHunt extends Equatable implements HomeFeed, BaseModel, EntityReactable {
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
  @override
  final Set<UserReaction> reactions;

  //entity
  final List<DirectMessage> messages;
  final String description;
  final String title;
  final int extraPoints;
  final int points;
  final String rewards;
  final DateTime startDate;
  final DateTime endDate;

  TreasureHunt({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.reactions = const {},
    this.messages = const [],
    this.description,
    this.title,
    this.extraPoints,
    this.points,
    this.rewards,
    this.startDate,
    this.endDate,
  });

  TreasureHunt copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    Set<UserReaction> reactions,
    List<DirectMessage> messages,
    String description,
    String title,
    int extraPoints,
    int points,
    String rewards,
    DateTime startDate,
    DateTime endDate,
  }) {
    return TreasureHunt(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      reactions: reactions ?? this.reactions,
      messages: messages ?? this.messages,
      description: description ?? this.description,
      title: title ?? this.title,
      extraPoints: extraPoints ?? this.extraPoints,
      points: points ?? this.points,
      rewards: rewards ?? this.rewards,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
      'reactions': reactions?.map((x) => x?.toMap())?.toList(),
      'messages': messages?.map((x) => x?.toMap())?.toList(),
      'description': description,
      'title': title,
      'extraPoints': extraPoints,
      'points': points,
      'rewards': rewards,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory TreasureHunt.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TreasureHunt(
      selector: map['selector'],
      createdBy: User(email: map['createdBy']),
      createdOn: Local(point: Point(latitude: map['latitude'], longitude :  map['longitude']), password:  map['password']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'],
      reactions: Set<UserReaction>.from(map['reactions']?.map((x) => UserReaction.fromMap(x)) ?? {}),
      messages: List<DirectMessage>.from(map['messages']?.map((x) => DirectMessage.fromMap(x)) ?? []),
      description: map['description'],
      title: map['title'],
      extraPoints: map['extraPoints'],
      points: map['points'],
      rewards: map['rewards'],
      startDate: DateTime.fromMillisecondsSinceEpoch(
          map['startDate'] ?? DateTime.now().millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          map['endDate'] ?? DateTime.now().millisecondsSinceEpoch),
    );
  }

  String toJson() => json.encode(toMap());

  factory TreasureHunt.fromJson(String source) =>
      TreasureHunt.fromMap(json.decode(source));

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
      reactions,
      messages,
      description,
      title,
      extraPoints,
      points,
      rewards,
      startDate,
      endDate,
    ];
  }
}
