import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';

class MessageDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<MessageRepository, MessageDataRepository>(
        (i) => MessageDataRepository());
  }
}
