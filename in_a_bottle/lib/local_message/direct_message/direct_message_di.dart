import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_repository.dart';
import 'package:in_a_bottle/local_message/direct_message/direct_message_storage.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';

class DirectMessageDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<DirectMessageStorage, DirectMessageDao>((i) => DirectMessageDao(),
        key: "MessageDao");

    injector.register<DirectMessageRepository, DirectMessageDataRepository>(
        (i) => DirectMessageDataRepository(i.get(key: "MessageDao")));

    injector.register((i) => DirectMessageBloc(
        navigator: i.get(),
        sessionRepository: i.get(),
        locationRepository: i.get(),
        messageDataRepository: i.get()));

    injector.register((i) => InteractDirectMessageBloc(
        messageRepository: i.get(), sessionRepository: i.get()));
  }
}
