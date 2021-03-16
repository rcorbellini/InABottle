import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/models/user.dart';
import 'package:in_a_bottle/features/session/domain/repositories/user_repository.dart';
import 'package:in_a_bottle/features/session/domain/use_cases/save_session_use_case.dart';

abstract class AuthByGoogleUseCase {
  Stream<User> call(String token);
}

class AuthByGoogleUseCaseImp extends AuthByGoogleUseCase {
  final UserRepository userRepository;
  final SaveSessionUseCase saveSessionUseCase;

  AuthByGoogleUseCaseImp(
      {required this.userRepository, required this.saveSessionUseCase});

  @override
  Stream<User> call(String token) async* {
    final user = await userRepository.loginByGoogle(token).first;

    saveSessionUseCase.call(Session<User>(payload: user, token: user.token!));

    yield user;
  }
}
