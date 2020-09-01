import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/message/message_storage.dart';
import 'package:in_a_bottle/local_message/message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/message/message_repository.dart';
import 'package:in_a_bottle/local_message/message/widgets/interact/interact_direct_message_bloc.dart';

class MessageDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<MessageStorage, MessageDao>((i) => MessageDao(),
        key: "MessageDao");

    injector.register<MessageRepository, MessageDataRepository>(
        (i) => MessageDataRepository(i.get(key: "MessageDao")));

    injector.register((i) => DirectMessageBloc(
        navigator: i.get(),
        sessionRepository: i.get(),
        locationRepository: i.get(),
        messageDataRepository: i.get()));

    injector.register((i) => InteractDirectMessageBloc(
        messageRepository: i.get(), sessionRepository: i.get()));
  }
}
