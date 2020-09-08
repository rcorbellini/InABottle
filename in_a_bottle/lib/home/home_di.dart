import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';

class HomeDi implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register((i) => HomeBloc(
        locationRepository: i.get(),
        talkRepository: i.get(), 
        chatRepository: i.get(),
        messageRepository: i.get(),
        sessionRepository: i.get(),
        treasureHuntRepository: i.get(),
        navigator: i.get()));
  }
}
