import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/session/session_bloc.dart.dart';
import 'package:in_a_bottle/session/session_event.dart';
import 'package:in_a_bottle/user/login_event.dart';
import 'package:meta/meta.dart';
import 'package:fancy_stream/fancy_stream.dart';

class LoginBloc extends BaseBloc<LoginEvent> {
  final SessionBloc sessionBloc;

  LoginBloc({@required this.sessionBloc});
  
  @override
  Future<void> onEvent(LoginEvent event) async{
    if (event is Logging) {
      sessionBloc.dispatchOn<SessionEvent>(LoggedIn(event.user));
    }
  }
}
