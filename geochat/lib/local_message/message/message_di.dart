import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/local_message/message/message_repository.dart';

class MessageDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<MessageRepository, MessageDataRepository>(
        (i) => MessageDataRepository());
  }
}
