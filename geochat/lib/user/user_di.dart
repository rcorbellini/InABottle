import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/user/login_bloc.dart';

class UserDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register((i) => LoginBloc(sessionBloc: i.get()));
  }
}
