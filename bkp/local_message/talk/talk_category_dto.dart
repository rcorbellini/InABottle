import 'dart:convert';

import 'package:equatable/equatable.dart';

class TalkCategory extends Equatable {
  final String description;
  final String imageUrl;

  const TalkCategory({
    this.description,
    this.imageUrl,
  });

  TalkCategory copyWith({
    String description,
    String imageUrl,
  }) {
    return TalkCategory(
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory TalkCategory.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TalkCategory(
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TalkCategory.fromJson(String source) =>
      TalkCategory.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [description, imageUrl];
}
