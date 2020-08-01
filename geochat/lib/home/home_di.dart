import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/home/home_bloc.dart';

class HomeDi implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register((i) => HomeBloc(
        talkRepository: i.get(),
        chatRepository: i.get(),
        messageRepository: i.get(),
        navigator: i.get()));
  }
}
