abstract class BaseRepository<E, K>{
  Future<List<E>> loadAll();
  
  Future<E> loadByKey(K key);

  Future save(E entity);

  Future saveAll(Iterable<E> entities);

  Future delete(K key);
}