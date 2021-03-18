import 'package:in_a_bottle/adapters/route/navigation_service.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/auth_by_google_use_case.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_event.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:in_a_bottle/features/session/presentation/login/bloc/login_status.dart';

class LoginBloc extends FancyDelegate {
  final AuthByGoogleUseCase authByGoogleUseCase;
  final NavigationService navigationService;

  LoginBloc(
      {required this.authByGoogleUseCase,
      required this.navigationService,
      fancy})
      : super(fancy: fancy) {
    listenOn<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event) async {
    if (event is LoggingByGoogle) {
      dispatchOn<LoginStatus>(LoadingStatus());
      final authUser = event.authUser;
      if (authUser == null) {
        return;
      }
      await authByGoogleUseCase.call(authUser.token).first;
      dispatchOn<LoginStatus>(LoggedStatus());
      navigationService.navigate("/");
    }
  }
}
