import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_repository.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/treasure_hunt_storage.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/message_treasure_bloc.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/treasure_hunt_bloc.dart';
import 'package:in_a_bottle/session/session_di.dart';

class TreasureHuntDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TreasureHuntStorage, TreasureHuntService>(
        (i) => TreasureHuntService(i.get(), baseUrl: i.get(key: api)),
        key: "TreasureHuntService");

    injector.register<TreasureHuntStorage, TreasureHuntDao>(
        (i) => TreasureHuntDao(),
        key: "TreasureHuntDao");

    injector.register<TreasureHuntRepository, TreasureHuntDataRepository>((i) =>
        TreasureHuntDataRepository(
            i.get(key: "TreasureHuntDao"), i.get(key: "TreasureHuntService")));

    injector.register(
      (i) => TreasureHuntBloc(
        navigator: i.get(),
        locationRepository: i.get(),
        treasureHuntRepository: i.get(),
        sessionRepository: i.get(),
      ),
    );

    injector.register(
      (i) => MessageTreasureBloc(
        navigator: i.get(),
        locationRepository: i.get(),
        sessionRepository: i.get(),
      ),
    );

    //injector.register((i) => InteractTreasureHuntBloc(
    //    messageRepository: i.get(), sessionRepository: i.get()));
  }
}
