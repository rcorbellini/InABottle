import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/user/login_bloc.dart';

class UserDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register((i) => LoginBloc(sessionBloc: i.get()));
  }
}
