import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/session/session_repository.dart';

class SessionDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    //TODO o que deve ser single é o datastore, mas a camada ainda não existe.
    injector.register((i) => SessionRepository(), isSingleton: true);
  }
}
