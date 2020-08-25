import 'dart:convert';

import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final String description;
  final bool selected;
  
  Tag({
    this.description,
    this.selected,
  });

  Tag copyWith({
    String descricao,
    bool selected,
  }) {
    return Tag(
      description: descricao ?? this.description,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'selected': selected,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Tag(
      description: map['description'],
      selected: map['selected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [description, selected];
}
