import 'package:fancy_stream/fancy_stream.dart';

abstract class BaseBloc<T> extends Disposable {
  BaseBloc() {
    listenOn<T>(onEvent);
  }

  void onEvent(T event);
}
