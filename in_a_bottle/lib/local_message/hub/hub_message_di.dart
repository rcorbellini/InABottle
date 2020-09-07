import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_storage.dart';
import 'package:in_a_bottle/local_message/hub/create/create_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/hub_message_repository.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/session/session_di.dart';

class HubMessageDI extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<HubMessageStorage, HubMessageDao>((i) => HubMessageDao(),
        key: "HubMessageDao");
    injector.register<HubMessageStorage, HubMessageService>(
        (i) => HubMessageService(i.get(), baseUrl: i.get(key: api)),
        key: "HubMessageService");

    injector.register<HubMessageRepository, HubMesageDataRepository>((i) =>
        HubMesageDataRepository(
            i.get(key: "HubMessageDao"), i.get(key: "HubMessageService")));

    injector.register(
      (i) => CreateHubMessageBloc(
        chatRepository: i.get(),
        locationRepository: i.get(),
        sessionRepository: i.get(),
        navigator: i.get(),
        tagRepository: i.get(),
      ),
    );

    injector.register(
      (injector) => InteractHubMessageBloc(
        chatRepository: injector.get(),
        sessionRepository: injector.get(),
      ),
    );
  }
}
