import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/features/session/session_di.dart';
import 'package:in_a_bottle/features/treasure_hunt/data/repositories/user_repository_imp.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/login/bloc/login_bloc.dart';
import 'package:in_a_bottle/features/treasure_hunt/domain/repositories/user_repository.dart';

class UserDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<UserRepository, UserRepositoryImp>((i) => UserRepositoryImp(i.get(), baseUrl: i.get(key: api)));
    injector.register((i) => LoginBloc(sessionBloc: i.get()));
  }
}
