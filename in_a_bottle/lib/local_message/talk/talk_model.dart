import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:in_a_bottle/_shared/archtecture/base_model.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/message/message_model.dart';
import 'package:in_a_bottle/local_message/talk/talk_category_dto.dart';

class Talk extends Equatable implements BaseModel {
  final String selector;
  final String title;
  final String descrition;
  final DateTime startDate;
  final DateTime endDate;
  final List<Message> openMessage;
  final List<Message> closeMessage;
  final TalkCategory mainCategory;
  final List<TalkCategory> categories;
  final int usersCount;
  final Local local;

  Talk({
    this.selector,
    this.title,
    this.descrition,
    this.startDate,
    this.endDate,
    this.openMessage,
    this.closeMessage,
    this.mainCategory,
    this.categories,
    this.usersCount,
    this.local,
  });

  @override
  List<Object> get props {
    return [
      selector,
      title,
      descrition,
      startDate,
      endDate,
      openMessage,
      closeMessage,
      mainCategory,
      categories,
      usersCount,
      local,
    ];
  }

  Talk copyWith({
    String selector,
    String title,
    String descrition,
    DateTime startDate,
    DateTime endDate,
    List<Message> openMessage,
    List<Message> closeMessage,
    TalkCategory mainCategory,
    List<TalkCategory> categories,
    int usersCount,
    Local local,
  }) {
    return Talk(
      selector: selector ?? this.selector,
      title: title ?? this.title,
      descrition: descrition ?? this.descrition,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      openMessage: openMessage ?? this.openMessage,
      closeMessage: closeMessage ?? this.closeMessage,
      mainCategory: mainCategory ?? this.mainCategory,
      categories: categories ?? this.categories,
      usersCount: usersCount ?? this.usersCount,
      local: local ?? this.local,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selector': selector,
      'title': title,
      'descrition': descrition,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'openMessage': openMessage?.map((x) => x?.toMap())?.toList(),
      'closeMessage': closeMessage?.map((x) => x?.toMap())?.toList(),
      'mainCategory': mainCategory?.toMap(),
      'categories': categories?.map((x) => x?.toMap())?.toList(),
      'usersCount': usersCount,
      'local': local?.toMap(),
    };
  }

  factory Talk.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Talk(
      selector: map['selector'],
      title: map['title'],
      descrition: map['descrition'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      openMessage: List<Message>.from(map['openMessage']?.map((x) => Message.fromMap(x))??[]),
      closeMessage: List<Message>.from(map['closeMessage']?.map((x) => Message.fromMap(x))??[]),
      mainCategory: TalkCategory.fromMap(map['mainCategory']),
      categories: List<TalkCategory>.from(map['categories']?.map((x) => TalkCategory.fromMap(x))??[]),
      usersCount: map['usersCount'],
      local: Local.fromMap(map['local']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Talk.fromJson(String source) => Talk.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
