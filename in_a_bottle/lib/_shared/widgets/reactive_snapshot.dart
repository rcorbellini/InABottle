import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReactiveTextController<T> extends StatefulWidget {
  final SnapshotBuilder builder;
  final T enumKey;
  final Disposable bloc;

  const ReactiveTextController(
      {Key key, this.builder, this.enumKey, this.bloc})
      : super(key: key);

  @override
  _ReactiveTextControllerState createState() => _ReactiveTextControllerState();
}

class _ReactiveTextControllerState extends State<ReactiveTextController> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.bloc.streamOf<String>(key: widget.enumKey.toString()),
        builder: (context, snap) {
          _controller.value = _controller.value.copyWith(text: snap.data);

          return widget.builder(
              _controller,
              snap?.error?.toString(),
              (String text) =>
                  widget.bloc.dispatchOn(text, key: widget.streamKey));
        });
  }

  String getKeyForm(){
    if(widget.enumKey is enum)
  }
}

typedef SnapshotBuilder = Widget Function(
    TextEditingController textEditingController,
    String error,
    Function(String text) onChanged);

extension EnumX on Object {
  String get asString => toString().split('.').last;
}
