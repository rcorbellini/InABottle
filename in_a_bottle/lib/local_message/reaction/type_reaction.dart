import 'dart:convert';

import 'package:equatable/equatable.dart';

class TypeReaction extends Equatable {
  final String selector;
  final String url;
  final String urlPreview;
  //screen element
  final int amount;

  const TypeReaction({
    this.selector,
    this.url,
    this.urlPreview,
    this.amount
  });

  @override
  List<Object> get props => [selector];

  TypeReaction copyWith({
    String selector,
    String url,
    String urlPreview,
    int amount,
  }) {
    return TypeReaction(
      selector: selector ?? this.selector,
      url: url ?? this.url,
      urlPreview: urlPreview ?? this.urlPreview,
      amount: amount ?? this.amount
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selector': selector,
      'url': url,
      'urlPreview': urlPreview
    };
  }

  factory TypeReaction.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TypeReaction(
      selector: map['selector'] as String,
      url: map['url'] as String,
      urlPreview : map['urlPreview'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeReaction.fromJson(String source) =>
      TypeReaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
