import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class TreasureHunt extends Equatable implements HomeFeed, BaseModel {
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
  

  //entity
  final List<DirectMessage> messages;
  final String description;
  final String title;
  final int extraPoints;

  TreasureHunt({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.messages,
    this.description,
    this.title,
    this.extraPoints,
  });

  TreasureHunt copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    List<DirectMessage> messages,
    String description,
    String title,
    int extraPoints,
  }) {
    return TreasureHunt(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      description: description ?? this.description,
      title: title ?? this.title,
      extraPoints: extraPoints ?? this.extraPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'createdBy': createdBy?.toMap(),
      'createdOn': createdOn?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'status': status,
      'messages': messages?.map((x) => x?.toMap())?.toList(),
      'description': description,
      'title': title,
      'extraPoints': extraPoints,
    };
  }

  factory TreasureHunt.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TreasureHunt(
      selector: map['selector'],
      createdBy: User.fromMap(map['createdBy']),
      createdOn: Local.fromMap(map['createdOn']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'],
      messages: List<DirectMessage>.from(map['messages']?.map((x) => DirectMessage.fromMap(x))),
      description: map['description'],
      title: map['title'],
      extraPoints: map['extraPoints'],
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
      messages,
      description,
      title,
      extraPoints,
    ];
  }
 
}
