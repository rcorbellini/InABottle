import 'package:fancy_factory/fancy_factory.dart';

abstract class TagRepository   {
  Future<List<Tag>> loadAll();
}

class TagDataRepository extends TagRepository {
  final memory = [
    Tag(description: "#TI"),
    Tag(description: "#ciencia"),
    Tag(description: "#teste"),
  ];
  
  @override
  Future<List<Tag>> loadAll() async {
    return memory;
  }

}
