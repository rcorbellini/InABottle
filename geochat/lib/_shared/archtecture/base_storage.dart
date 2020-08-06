abstract class BaseStorage<E, K> {
  Future<List<E>> loadAll();

  Future<E> loadByKey(K key);

  Future save();

  Future saveAll();

  Future deleteByKey(K key);
}
