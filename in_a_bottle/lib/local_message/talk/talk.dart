import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fancy_factory/fancy_factory.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/local_message/local/local.dart';
import 'package:in_a_bottle/local_message/message/message.dart';
import 'package:in_a_bottle/local_message/talk/talk_category_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class Talk extends Equatable implements BaseModel {
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
  final String title;
  final String descrition;
  final DateTime startDate;
  final DateTime endDate;
  final List<Message> openMessage;
  final List<Message> closeMessage;
  final TalkCategory mainCategory;
  final List<Tag> categories;
  final int usersCount;

  Talk({
    this.selector,
    this.createdBy,
    this.createdOn,
    this.createdAt,
    this.status,
    this.title,
    this.descrition,
    this.startDate,
    this.endDate,
    this.openMessage,
    this.closeMessage,
    this.mainCategory,
    this.categories,
    this.usersCount,
  });

  @override
  List<Object> get props {
    return [
      selector,
      createdBy,
      createdOn,
      createdAt,
      status,
      title,
      descrition,
      startDate,
      endDate,
      openMessage,
      closeMessage,
      mainCategory,
      categories,
      usersCount,
    ];
  }

  Talk copyWith({
    String selector,
    User createdBy,
    Local createdOn,
    DateTime createdAt,
    String status,
    String title,
    String descrition,
    DateTime startDate,
    DateTime endDate,
    List<Message> openMessage,
    List<Message> closeMessage,
    TalkCategory mainCategory,
    List<Tag> categories,
    int usersCount,
  }) {
    return Talk(
      selector: selector ?? this.selector,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      title: title ?? this.title,
      descrition: descrition ?? this.descrition,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      openMessage: openMessage ?? this.openMessage,
      closeMessage: closeMessage ?? this.closeMessage,
      mainCategory: mainCategory ?? this.mainCategory,
      categories: categories ?? this.categories,
      usersCount: usersCount ?? this.usersCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'createdBy': createdBy?.toMap(),
      'createdOn': createdOn?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'status': status,
      'title': title,
      'descrition': descrition,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'openMessage': openMessage?.map((x) => x?.toMap())?.toList(),
      'closeMessage': closeMessage?.map((x) => x?.toMap())?.toList(),
      'mainCategory': mainCategory?.toMap(),
      'categories': categories?.map((x) => x?.toMap())?.toList(),
      'usersCount': usersCount,
    };
  }

  factory Talk.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Talk(
      selector: map['selector'],
      createdBy: User.fromMap(map['createdBy']),
      createdOn: Local.fromMap(map['createdOn']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'],
      title: map['title'],
      descrition: map['descrition'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      openMessage: List<Message>.from(map['openMessage']?.map((x) => Message.fromMap(x))),
      closeMessage: List<Message>.from(map['closeMessage']?.map((x) => Message.fromMap(x))),
      mainCategory: TalkCategory.fromMap(map['mainCategory']),
      categories: List<Tag>.from(map['categories']?.map((x) => Tag.fromMap(x))),
      usersCount: map['usersCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Talk.fromJson(String source) => Talk.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
