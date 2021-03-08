import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/features/session/session_di.dart';
import 'package:in_a_bottle/features/user/login_bloc.dart';
import 'package:in_a_bottle/features/user/user_repository.dart';

class UserDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<UserRepository, UserDataRepository>((i) => UserDataRepository(i.get(), baseUrl: i.get(key: api)));
    injector.register((i) => LoginBloc(sessionBloc: i.get()));
  }
}
