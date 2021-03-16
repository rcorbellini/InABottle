import 'package:in_a_bottle/features/session/domain/use_cases/auth_by_google_use_case.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_event.dart';
import 'package:fancy_stream/fancy_stream.dart';

class LoginBloc extends FancyDelegate {
  final AuthByGoogleUseCase authByGoogleUseCase;

  LoginBloc({required this.authByGoogleUseCase, fancy}) : super(fancy: fancy) {
    listenOn<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event) async {
    if (event is LoggingByGoogle) {
      final authUser = event.authUser;
      if (authUser == null) {
        return;
      }
      authByGoogleUseCase.call(authUser.token);
    }
  }
}
