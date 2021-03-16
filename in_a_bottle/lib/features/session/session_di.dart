import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/features/session/data/data_sources/session_cache_data_source.dart';
import 'package:in_a_bottle/features/session/data/data_sources/user_remote_data_source.dart';
import 'package:in_a_bottle/features/session/data/repositories/session_repository_imp.dart';
import 'package:in_a_bottle/features/session/data/repositories/user_repository_imp.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:in_a_bottle/features/session/domain/repositories/user_repository.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/auth_by_google_use_case.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/get_session_use_case.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/logout_session_use_case.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/save_session_use_case.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_bloc.dart';

class SessionDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    injector
      ..register((injector) => "http://04c02d1cabed.ngrok.io", key: api)

      //data
      ..register<SessionCacheDataSource, SessionCacheDataSourceImp>(
          (i) => SessionCacheDataSourceImp())
      ..register<SessionRepository, SessionRepositoryImp>(
          (i) => SessionRepositoryImp(cache: i.get()))
      ..register<UserRemoteDataSource, UserRemoteDataSourceImp>(
          (i) => UserRemoteDataSourceImp(http2client: i.get()))
      ..register<UserRepository, UserRepositoryImp>(
          (i) => UserRepositoryImp(remote: i.get()))

      //domain
      ..register<GetSessionUseCase, GetSessionUseCaseImp>(
          (i) => GetSessionUseCaseImp(sessionRepository: i.get()))
      ..register<SaveSessionUseCase, SaveSessionUseCaseImp>(
          (i) => SaveSessionUseCaseImp(sessionRepository: i.get()))
      ..register<LogoutSessionUseCase, LogoutSessionUseCaseImp>(
          (i) => LogoutSessionUseCaseImp(sessionRepository: i.get()))
      ..register<AuthByGoogleUseCase, AuthByGoogleUseCaseImp>((i) =>
          AuthByGoogleUseCaseImp(
              userRepository: i.get(), saveSessionUseCase: i.get()))

      //presentation
      ..register((injector) => LoginBloc(authByGoogleUseCase: injector.get()));
  }
}

const String api = "API";
