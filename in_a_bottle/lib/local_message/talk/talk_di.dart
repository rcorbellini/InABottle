import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/talk/talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';

class TalkDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TalkRepository, TalkDataRepository>(
        (i) => TalkDataRepository());

    injector
        .register((i) => TalkBloc(talkRepository: i.get(), navigator: i.get()));
  }
}
