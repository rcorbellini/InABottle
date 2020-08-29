abstract class BaseDataStorage<E, K>{
  Future<Iterable<E>> loadAll();
  
  Future<E> loadByKey(K key);

  Future update(E entity);

  Future insert(E entity);

  Future saveAll(Iterable<E> entities);

  Future delete(K key);
}