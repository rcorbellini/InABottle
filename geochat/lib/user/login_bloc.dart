import 'package:geochat/_shared/archtecture/base_bloc.dart';
import 'package:geochat/session/session_bloc.dart';
import 'package:geochat/session/session_event.dart';
import 'package:geochat/user/login_event.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class LoginBloc extends BaseBloc<LoginEvent> {
  final SessionBloc sessionBloc;

  LoginBloc({@required this.sessionBloc});
  
  @override
  void onEvent(LoginEvent event) {
    if (event is Logging) {
      sessionBloc.dispatchOn<SessionEvent>(LoggedIn(event.user));
    }
  }
}
