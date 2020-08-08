import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/local_message/message/direct_message_event.dart';

class DirectMessageBloc extends BaseBloc<DirectMessageEvent> {
  static const String route = "/addDirectMessage";

  DirectMessageBloc() {
    listenOn<String>(print, key: "text");
    listenOn<String>(print, key: "title");
    dispatchOn<String>("teste", key: "text");
  }

  @override
  void onEvent(DirectMessageEvent event) {}
}
