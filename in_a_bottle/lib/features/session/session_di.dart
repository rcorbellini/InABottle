import 'package:dio/dio.dart';
import 'package:in_a_bottle/adapters/data_storage/memory/memory_storage.dart';
import 'package:in_a_bottle/adapters/data_storage/memory/memory_storage_imp.dart';
import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/location/location_repository.dart';
import 'package:in_a_bottle/adapters/widgets/message_handler.dart';
import 'package:in_a_bottle/features/session/data/repositories/session_repository_imp.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/get_session_use_case.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/logout_session_use_case.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/save_session_use_case.dart';

class SessionDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    //TODO por no lugar dele
    injector.register<LocationRepository, LocationDataRepository>(
        (i) => LocationDataRepository());
    injector.register<MessageHandler, FlushMessageHandler>(
        (injector) => FlushMessageHandler());
    injector.register((injector) => Dio());

    injector.register((injector) => "http://04c02d1cabed.ngrok.io", key: api);

    //DAQUI PRA BAIXO TA CERTO
    var sessionKey = "session";
    injector.register<MemoryStorage, MemoryStorageImp>(
        (i) => MemoryStorageImp(),
        key: sessionKey,
        isSingleton: true);
    injector.register<SessionRepository, SessionRepositoryImp>(
        (i) => SessionRepositoryImp(memory: i.get(key: sessionKey)));

    injector.register<GetSessionUseCase, GetSessionUseCaseImp>(
        (i) => GetSessionUseCaseImp(sessionRepository: i.get()));
    injector.register<SaveSessionUseCase, SaveSessionUseCaseImp>(
        (i) => SaveSessionUseCaseImp(sessionRepository: i.get()));
    injector.register<LogoutSessionUseCase, LogoutSessionUseCaseImp>(
        (i) => LogoutSessionUseCaseImp(sessionRepository: i.get()));
  }
}

const String api = "API";
