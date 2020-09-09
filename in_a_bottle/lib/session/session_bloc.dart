import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/session/session_dto.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:in_a_bottle/user/user.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class SessionBloc extends BaseBloc<SessionEvent> {
  final SessionRepository sessionRepository;

  SessionBloc({@required this.sessionRepository}) {
    dispatchOn<SessionEvent>(Unauthenticated());
  }

  @override
  Future<void> onEvent(SessionEvent event) async {
    if (event is LoggedIn) {
      _loggedin(event.user);
    } else if (event is LoggedOut) {
      _loggedOut();
    }
  }

  void _loggedin(User user) {
    sessionRepository.save(Session(user: user));
  }

  void _loggedOut() {
    sessionRepository.clean();
  }
}
