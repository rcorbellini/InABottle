abstract class KeyValueStorage {

  Future<void> setValue<T>(String key, T value);


   Future<T> getValue<T>(String key);

}