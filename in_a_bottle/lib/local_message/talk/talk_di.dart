import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/local_message/talk/talk_storage.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/talk_repository.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:in_a_bottle/session/session_di.dart';

class TalkDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TalkStorage, TalkDao>((i) => TalkDao(), key: "TalkDao");

    injector.register<TalkStorage, TalkService>(
        (i) => TalkService(i.get(), baseUrl: i.get(key: api)),
        key: "TalkService");

    injector.register<TalkRepository, TalkDataRepository>((i) =>
        TalkDataRepository(i.get(key: "TalkDao"), i.get(key: "TalkService")));

    injector.register(
      (i) => TalkBloc(
        talkRepository: i.get(),
        sessionRepository: i.get(),
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
