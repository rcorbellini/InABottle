import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/hub/create/create_chat_bloc.dart';
import 'package:in_a_bottle/local_message/hub/chat_repository.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_chat_bloc.dart';

class ChatDI extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<ChatRepository, ChatDataRepository>(
        (i) => ChatDataRepository());

    injector.register((i) => CreateChatBloc(
          chatRepository: i.get(),
          locationRepository: i.get(),
          sessionRepository: i.get(),
          navigator: i.get(),
          tagRepository: i.get()
        ));

    injector.register((injector) => InteractChatBloc(
        chatRepository: injector.get(), sessionRepository: injector.get()));
  }
}
