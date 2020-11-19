import 'package:dio/dio.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/_shared/location/location_repository.dart';
import 'package:in_a_bottle/_shared/widgets/message_handler.dart';
import 'package:in_a_bottle/common/widget/locked/lock_bloc.dart';
import 'package:in_a_bottle/local_message/tag/tag_repository.dart';
import 'package:in_a_bottle/session/session_bloc.dart';
import 'package:in_a_bottle/session/session_repository.dart';

class SessionDi extends InjectorModule {
  @override
  void initialise(Injector injector) {
    //TODO por no lugar dele
    injector.register<LocationRepository, LocationDataRepository>(
        (i) => LocationDataRepository());
    injector.register<MessageHandler, FlushMessageHandler>(
        (injector) => FlushMessageHandler());
    injector.register((injector) => LockBloc());
    injector.register<TagRepository, TagDataRepository>((i)=> TagDataRepository());
    injector.register((injector) => Dio());

    injector.register((injector) => "http://2fce1cafea8e.ngrok.io", key: api);

    //TODO o que deve ser single é o datastore, mas a camada ainda não existe.
    injector.register<SessionRepository, SessionDataRepository>(
        (i) => SessionDataRepository(),
        isSingleton: true);
    injector.register((i) => SessionBloc(sessionRepository: i.get()),
        isSingleton: true);
  }
}


const String api = "API";