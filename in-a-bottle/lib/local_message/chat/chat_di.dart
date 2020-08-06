import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/local_message/chat/chat_repository.dart';

class ChatDI extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<ChatRepository, ChatDataRepository>(
        (i) => ChatDataRepository());
  }
}
