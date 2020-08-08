import 'package:flutter/material.dart';

class ReactiveSnapshot extends StatefulWidget {
  final Stream<String> stream;
  final SnapshotBuilder builder;
  const ReactiveSnapshot({Key key, this.stream, this.builder})
      : super(key: key);

  @override
  _ReactiveSnapshotState createState() => _ReactiveSnapshotState();
}

class _ReactiveSnapshotState extends State<ReactiveSnapshot> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snap) {
          _controller.value = _controller.value.copyWith(text: snap.data);

          return widget.builder(_controller, snap?.error?.toString());
        });
  }
}

typedef SnapshotBuilder = Widget Function(
    TextEditingController textEditingController, String error);
