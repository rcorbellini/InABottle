import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';


class SessionBloc extends BaseBloc<SessionEvent> {
  final SessionRepository sessionRepository;

  SessionBloc({@required this.sessionRepository}){
    dispatchOn<SessionEvent>(Unauthenticated()); 
  }


  @override
  void onEvent(SessionEvent event) {

  }
}
