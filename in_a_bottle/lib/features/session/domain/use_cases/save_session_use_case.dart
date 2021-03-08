
import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';

abstract class SaveSessionUseCase{

  Future<void> invoke(Session session);
}


class SaveSessionUseCaseImp extends SaveSessionUseCase{
  SessionRepository sessionRepository;

  SaveSessionUseCaseImp({required this.sessionRepository});

  @override
  Future<void> invoke(Session session) => sessionRepository.save(session);

}