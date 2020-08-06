import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/session/session_bloc.dart';
import 'package:in_a_bottle/session/session_repository.dart';

class SessionDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    //TODO o que deve ser single é o datastore, mas a camada ainda não existe.
    injector.register((i) => SessionRepository(), isSingleton: true);
    injector.register((i) => SessionBloc(sessionRepository: i.get()),
        isSingleton: true);
  }
}
