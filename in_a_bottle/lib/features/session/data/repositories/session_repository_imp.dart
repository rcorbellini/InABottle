import 'package:in_a_bottle/adapters/data_storage/memory/memory_storage.dart';
import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';

class SessionRepositoryImp implements SessionRepository {
  MemoryStorage memory;

  SessionRepositoryImp({required this.memory});

  @override
  Future<Session<T>?> load<T>() async {
    return memory.load() as Session<T>;
  }

  @override
  Future save(Session entity) async {
    memory.store(entity);
  }

  @override
  Future<void> clean() async {
    memory.store(null);
  }
}
