import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/chat/chat_repository.dart';

class ChatDI extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<ChatRepository, ChatDataRepository>(
        (i) => ChatDataRepository());
  }
}
