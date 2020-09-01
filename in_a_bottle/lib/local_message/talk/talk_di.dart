import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/talk/talk_storage.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';

class TalkDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TalkStorage, TalkDao>((i) => TalkDao(), key: "TalkDao");

    injector.register<TalkRepository, TalkDataRepository>(
      (i) => TalkDataRepository(i.get(key: "TalkDao")),
    );

    injector.register(
      (i) => TalkBloc(
        talkRepository: i.get(),
        navigator: i.get(),
        locationRepository: i.get(),
      ),
    );

    injector.register(
      (injector) => InteractTalkBloc(
        talkRepository: injector.get(),
        sessionRepository: injector.get(),
      ),
    );
  }
}
