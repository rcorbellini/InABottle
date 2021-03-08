abstract class BaseDataStorage<E, K>{
  Future<List<E>> loadAll();
  
  Future<E> loadByKey(K key);

  Future update(String key, E entity);

  Future<String> insert(E entity);

  //Future saveAll(Iterable<E> entities);

  Future delete(K key);
}