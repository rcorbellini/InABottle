import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters//utils.dart';

class ReactiveTextBuilder<T> extends StatefulWidget {
  final SnapshotBuilder builder;
  final T keyForm;
  final Disposable bloc;

  ReactiveTextBuilder({required Key key, required this.builder, required this.keyForm, required this.bloc})
      : assert(isEnum(keyForm), 'The KeyForm Must be a enum'),
        super(key: key);

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
        stream: widget.bloc.streamOf<String>(key: widget.keyForm),
        builder: (context, snap) {
          _controller.value = _controller.value.copyWith(text: snap.data);

          return widget.builder(
            _controller,
            (String text) => widget.bloc.dispatchOn(text, key: widget.keyForm),
            snap.error?.toString(),
          );
        });
  }
}

typedef SnapshotBuilder = Widget Function(
  TextEditingController textEditingController,
  Function(String text) onChanged,
  String? error,
);
