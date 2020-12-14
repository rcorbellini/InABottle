import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/session/session_dto.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:in_a_bottle/session/session_repository.dart';
import 'package:in_a_bottle/user/user.dart';
import 'package:in_a_bottle/user/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class SessionBloc extends BaseBloc<SessionEvent> {
  final SessionRepository sessionRepository;
  final UserRepository userRepository;

  SessionBloc(
      {@required this.sessionRepository, @required this.userRepository}) {
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

  Future<void> _loggedin(User user) async{
    final token =  await userRepository.login(user);
    await sessionRepository.save(Session(user: user, token: token));
  }

  void _loggedOut() {
    sessionRepository.clean();
  }
}
