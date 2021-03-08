
import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';

abstract class GetSessionUseCase{

  Future<Session<T>?> invoke<T>();
}


class GetSessionUseCaseImp extends GetSessionUseCase{
  SessionRepository sessionRepository;

  GetSessionUseCaseImp({required this.sessionRepository});

  @override
  Future<Session<T>?> invoke<T>() => sessionRepository.load();

}