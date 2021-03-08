
import 'package:in_a_bottle/adapters/data_storage/memory/memory_storage.dart';

class MemoryStorageImp extends MemoryStorage{

  late Object? object;

  void store(Object? object){
    this.object = object;
  }

  Object? load() => this.object;
}