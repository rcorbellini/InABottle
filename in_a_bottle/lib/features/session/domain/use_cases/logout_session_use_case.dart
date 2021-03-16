
import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';

abstract class LogoutSessionUseCase{

  Future<void> call();
}


class LogoutSessionUseCaseImp extends LogoutSessionUseCase{
  SessionRepository sessionRepository;

  LogoutSessionUseCaseImp({required this.sessionRepository});

  @override
  Future<void> call() => sessionRepository.clean();

}