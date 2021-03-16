import 'package:in_a_bottle/features/session/domain/models/session.dart';

///Interface para o armazenamento da session.
abstract class SessionCacheDataSource {
  Session? load();

  void clean();

  void store(Session session);
}


///Imprementacao do session in memory.
class SessionCacheDataSourceImp implements SessionCacheDataSource {
  factory SessionCacheDataSourceImp(){
    return _instance;
  }
  static SessionCacheDataSourceImp _instance = SessionCacheDataSourceImp._();

  SessionCacheDataSourceImp._();

  Session? session;

  @override
  void clean() => session = null;

  @override
  Session? load() => session;

  @override
  void store(Session session) => this.session = session;
}
