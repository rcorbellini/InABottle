import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/bloc/home_bloc.dart';

class HomeDi implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register((i) => HomeBloc(
        locationRepository: i.get(),
        talkRepository: i.get(),
        hubRepository: i.get(),
        messageRepository: i.get(),
        sessionRepository: i.get(),
        treasureHuntRepository: i.get(),
        navigator: i.get()));
  }
}
