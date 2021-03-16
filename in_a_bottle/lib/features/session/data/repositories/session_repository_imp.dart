import 'package:in_a_bottle/features/session/data/data_sources/session_cache_data_source.dart';
import 'package:in_a_bottle/features/session/domain/models/session.dart';
import 'package:in_a_bottle/features/session/domain/repositories/session_repository.dart';

class SessionRepositoryImp implements SessionRepository {
  SessionCacheDataSource cache;

  SessionRepositoryImp({required this.cache});

  @override
  Future<Session<T>?> load<T>() async {
    return cache.load() as Session<T>?;
  }

  @override
  Future save(Session entity) async {
    cache.store(entity);
  }

  @override
  Future<void> clean() async {
    cache.clean();
  }
}
