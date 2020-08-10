import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReactiveTextBuilder<T> extends StatefulWidget {
  final SnapshotBuilder builder;
  final T keyForm;
  final Disposable bloc;

  ReactiveTextBuilder({Key key, this.builder, this.keyForm, this.bloc})
      : assert(isEnum(keyForm), 'The KeyForm Must be a enum'),
        super(key: key);

  bool isEnum(T data) {
    final split = data.toString().split('.');
    return split.length > 1 && split[0] == data.runtimeType.toString();
  }

  @override
  _ReactiveTextBuilderState createState() => _ReactiveTextBuilderState();
}

class _ReactiveTextBuilderState extends State<ReactiveTextBuilder> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.bloc.streamOf<String>(key: keyForm),
        builder: (context, snap) {
          _controller.value = _controller.value.copyWith(text: snap.data);

          return widget.builder(_controller, snap?.error?.toString(),
              (String text) => widget.bloc.dispatchOn(text, key: keyForm));
        });
  }

  String get keyForm => widget.keyForm.toString().split('.').last;
}

typedef SnapshotBuilder = Widget Function(
    TextEditingController textEditingController,
    String error,
    Function(String text) onChanged);
