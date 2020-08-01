import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/local_message/talk/talk_repository.dart';

class HomeDi implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TalkRepository, TalkDataRepository>(
        (i) => TalkDataRepository());

    injector
        .register((i) => HomeBloc(talkRepository: i.get(), navigator: i.get()));
  }
}
