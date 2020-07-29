abstract class BaseRepository<E, K>{
  Future<List<E>> loadAll();
  
  Future<E> loadByKey(K key);

  Future save();

  Future saveAll();

  Future delete();
}