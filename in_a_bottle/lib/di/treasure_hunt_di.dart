import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/features/session/session_di.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/data_sources/treasure_hunt_storage.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/repositories/treasure_hunt_repository_imp.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/repositories/treasure_hunt_repository.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/treasure_hunt/bloc/message_treasure_bloc.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/treasure_hunt/bloc/treasure_hunt_bloc.dart';

class TreasureHuntDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TreasureHuntStorage, TreasureHuntService>(
        (i) => TreasureHuntService(),
        key: "TreasureHuntService");

    injector.register<TreasureHuntStorage, TreasureHuntDao>(
        (i) => TreasureHuntDao(),
        key: "TreasureHuntDao");

    injector.register<TreasureHuntRepository, TreasureHuntRepositoryImp>((i) =>
        TreasureHuntRepositoryImp(
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
