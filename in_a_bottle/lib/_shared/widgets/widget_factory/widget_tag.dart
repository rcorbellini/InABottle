import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/local_message/tag/tag.dart';

class WidgetTag<T> extends StatelessWidget {
  final T enumValue;
  final BaseBloc bloc;
  final Map<String, dynamic> parameters;

  const WidgetTag({Key key, this.enumValue, this.bloc, this.parameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tag>>(
      stream: bloc.streamOf(key: enumValue),
      builder: (date, snapshot) {
        final tags = snapshot.data ?? [];
        return Tags(
          itemCount: tags.length,
          itemBuilder: (int index) {
            return ItemTags(
              singleItem: false,
              title: tags[index].description,
              index: index,
              active: tags[index].selected ?? false,
              onPressed: (item) {
                final tagsEdited = tags.map((e) {
                  if (e.description == item.title) {
                    return e.copyWith(selected: item.active);
                  }
                  return e;
                }).toList();
                bloc.dispatchOn(tagsEdited, key: enumValue);
              },
              
            );
          },
        );
      },
    );
  }
}
