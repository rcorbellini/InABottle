import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/local_message/talk/talk_repository.dart';

class TalkDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<TalkRepository, TalkDataRepository>(
        (i) => TalkDataRepository());
  }
}
