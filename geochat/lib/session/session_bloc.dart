import 'package:geochat/_shared/archtecture/base_bloc.dart';
import 'package:geochat/session/session_event.dart';
import 'package:geochat/session/session_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';


class SessionBloc extends BaseBloc {
  final SessionRepository sessionRepository;

  SessionBloc({@required this.sessionRepository}){
    dispatchOn<SessionEvent>(Unauthenticated()); 
  }
}
